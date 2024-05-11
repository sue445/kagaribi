# frozen_string_literal: true

module Kagaribi
  class Collection
    # @!attribute [r] collection_name
    #   @return [String]
    attr_reader :collection_name

    # @!attribute [r] logger
    #   @return [Logger]
    attr_reader :logger

    # @param collection_name [String]
    # @param logger [Logger] default is `STDOUT` Logger
    def initialize(collection_name, logger: nil)
      @collection_name = collection_name

      @logger =
        if logger
          logger
        else
          Logger.new($stdout)
        end
    end

    # @param doc_key [String]
    # @param params [Hash]
    def set(doc_key, params)
      ref = firestore.doc(full_doc_key(doc_key))
      ref.set(params)
    end

    # @param key [String]
    # @return [String]
    def self.sanitize_key(key)
      key&.tr("/", "-")
    end

    private

    # @return [Google::Cloud::Firestore]
    def firestore
      @firestore ||= Google::Cloud::Firestore.new
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
  end
end
