# frozen_string_literal: true

require "google/cloud/firestore"
require "logger"

require_relative "kagaribi/version"

module Kagaribi
  class Error < StandardError; end

  autoload :Collection, "kagaribi/collection"
end
