# frozen_string_literal: true

module Kagaribi
  class Collection
    MAX_RETRY_COUNT = 5

    # @!attribute [r] collection_name
    #   @return [String]
    attr_reader :collection_name

    # @!attribute [r] database_id
    #   @return [String,nil]
    attr_reader :database_id

    # @!attribute [r] logger
    #   @return [Logger]
    attr_reader :logger

    # @param collection_name [String]
    # @param database_id [String,nil] Identifier for a Firestore database. If not present, the default database of the project is used.
    # @param logger [Logger] default is `STDOUT` Logger
    def initialize(collection_name, database_id: nil, logger: nil)
      @collection_name = collection_name
      @database_id = database_id

      @logger =
        if logger
          logger
        else
          Logger.new($stdout)
        end
    end

    # Save a document to collection
    # @note If a document with the same key exists, it is overwritten.
    # @param doc_key [String]
    # @param data [Hash]
    def set(doc_key, data)
      ref = firestore.doc(full_doc_key(doc_key))
      ref.set(data)
    end

    # Update a document that has already been saved
    # @note If a document with the same key exists, it is merged.
    # @param doc_key [String]
    # @param data [Hash]
    def update(doc_key, data)
      ref = firestore.doc(full_doc_key(doc_key))
      ref.update(data)
    end

    # Get document from collection
    # @param doc_key [String]
    # @return [Hash<Symbol,Object>] return empty Hash if document isn't found
    def get(doc_key)
      with_retry("Kagaribi::Collection#get") do
        ref = firestore.doc(full_doc_key(doc_key))
        snap = ref.get
        snap&.data || {}
      end
    end

    # Whether document is exists in collection
    # @param doc_key [String]
    # @return [Boolean]
    def exists?(doc_key)
      with_retry("Kagaribi::Collection#exists?") do
        ref = firestore.doc(full_doc_key(doc_key))
        snap = ref.get
        snap&.exists?
      end
    end

    # Delete document in collection
    # @param doc_key [String]
    def delete(doc_key)
      ref = firestore.doc(full_doc_key(doc_key))
      ref.delete
    end

    # @param key [String]
    # @return [String]
    def self.sanitize_key(key)
      key.tr("/", "-")
    end

    private

    # @return [Google::Cloud::Firestore]
    def firestore
      @firestore ||= Google::Cloud::Firestore.new(database_id: database_id)
    end

    # @return [String]
    def sanitized_collection_name
      sanitize_key(@collection_name)
    end

    # @param key [String]
    # @return [String]
    def sanitize_key(key)
      Collection.sanitize_key(key)
    end

    # @param doc_key [String]
    # @return [String]
    def full_doc_key(doc_key)
      "#{sanitized_collection_name}/#{sanitize_key(doc_key)}"
    end

    # @param label [String]
    # @yield
    def with_retry(label)
      yield
    rescue TypeError, GRPC::Unavailable, RuntimeError, Signet::AuthorizationError => error
      raise error unless retryable_error?(error)

      retry_count ||= 0
      retry_count += 1

      raise error if retry_count > MAX_RETRY_COUNT

      logger.warn "[#{label}] collection_name=#{@collection_name}, retry_count=#{retry_count}, error=#{error}"
      sleep 1
      retry
    end

    # @param error [StandardError]
    # @return [Boolean]
    def retryable_error?(error)
      case error
      when RuntimeError
        # e.g.
        # Could not load the default credentials. Browse to
        # https://developers.google.com/accounts/docs/application-default-credentials
        # for more information
        return true if error.message.include?("Could not load the default credentials.")

        # e.g.
        # Your credentials were not found. To set up Application Default
        # Credentials for your environment, see
        # https://cloud.google.com/docs/authentication/external/set-up-adc
        return true if error.message.include?("Your credentials were not found.")

        return false
      end

      true
    end
  end
end
