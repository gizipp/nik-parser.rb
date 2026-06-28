# frozen_string_literal: true

require "json"

module NikParser
  # Loads and caches Indonesian regional data.
  module Region
    DATA_PATH = File.expand_path("data/regions.json", __dir__)

    class << self
      # Get all data (cached).
      #
      # @return [Hash]
      def data
        @data ||= JSON.parse(File.read(DATA_PATH))
      end

      # Look up province by code.
      #
      # @param code [String] 2-digit province code
      # @return [String, nil]
      def province(code)
        data["province"][code]
      end

      # Look up regency by code.
      #
      # @param code [String] 4-digit regency code
      # @return [String, nil]
      def regency(code)
        data["regency"][code]
      end

      # Look up district by code.
      #
      # @param code [String] 6-digit district code
      # @return [String, nil]
      def district(code)
        data["district"][code]
      end

      # Reset cached data (useful for testing).
      def reset!
        @data = nil
      end
    end
  end
end
