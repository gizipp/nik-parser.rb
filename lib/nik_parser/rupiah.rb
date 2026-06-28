# frozen_string_literal: true

module NikParser
  # Indonesian Rupiah formatting.
  module Rupiah
    module_function

    # Format a number as Rupiah.
    #
    # @param amount [Numeric]
    # @param symbol [Boolean] include "Rp" prefix
    # @return [String] e.g. "Rp 1.500.000"
    def format(amount, symbol: true)
      # Handle negative
      negative = amount.to_i < 0
      digits = amount.to_i.abs.to_s

      # Add thousand separators (dot)
      formatted = digits.gsub(/(\d)(?=(\d{3})+$)/, '\1.')
      formatted = "-#{formatted}" if negative

      symbol ? "Rp #{formatted}" : formatted
    end

    # Parse Rupiah string to integer.
    #
    # @param rupiah [String] e.g. "Rp 1.500.000" or "1500000"
    # @return [Integer]
    def parse(rupiah)
      rupiah.gsub(/[^0-9\-]/, "").to_i
    end
  end
end
