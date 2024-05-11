# frozen_string_literal: true

require "google/cloud/firestore"
require "logger"

require_relative "kagaribi/version"

module Kagaribi
  class Error < StandardError; end

  autoload :Collection, "kagaribi/collection"

  # @param collection_name [String]
  # @param database_id [String,nil] Identifier for a Firestore database. If not present, the default database of the project is used.
  # @param logger [Logger] default is `STDOUT` Logger
  # @return [Kagaribi::Collection]
  def self.collection(collection_name, database_id: nil, logger: nil)
    Collection.new(collection_name, database_id: database_id, logger: logger)
  end
end
