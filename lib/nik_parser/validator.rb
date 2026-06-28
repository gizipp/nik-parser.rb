# frozen_string_literal: true

module NikParser
  # NIK validation.
  module Validator
    module_function

    # Validate a NIK string.
    #
    # Checks:
    # - Length is exactly 16 digits
    # - All characters are digits
    # - Province code exists in data
    # - Regency code exists in data
    #
    # @param nik [String]
    # @return [Boolean]
    def valid_nik?(nik)
      return false unless nik.is_a?(String)
      return false unless nik.match?(/\A\d{16}\z/)

      province_code = nik[0..1]
      regency_code = nik[0..3]
      district_code = nik[0..5]

      # Province must exist
      return false if Region.province(province_code).nil?
      # Regency must exist
      return false if Region.regency(regency_code).nil?
      # District must exist
      return false if Region.district(district_code).nil?

      # Day must be valid (1-31 for male, 41-71 for female)
      day_code = nik[6..7].to_i
      return false if day_code > 71
      return false if day_code > 31 && day_code < 41

      # Month must be valid (01-12)
      month = nik[8..9].to_i
      return false if month < 1 || month > 12

      true
    end
  end
end
