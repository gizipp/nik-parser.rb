# frozen_string_literal: true

module NikParser
  # NPWP (Nomor Pokok Wajib Pajak) validation.
  #
  # Format: XX.XXX.XXX.X-XXX.XXX (15 digits)
  #
  # Structure:
  # - Digits 1-2: KPP (Kantor Pelayanan Pajak) code
  # - Digits 3-8: Registration serial number
  # - Digit 9: Type (9 = corporate, 0-8 = personal)
  # - Digit 10: Check digit
  # - Digits 11-13: Branch code (000 = main)
  #
  module NPWP
    module_function

    # Validate NPWP format.
    #
    # @param npwp [String]
    # @return [Boolean]
    def valid?(npwp)
      return false unless npwp.is_a?(String)

      digits = npwp.gsub(/[^0-9]/, "")
      return false unless digits.length == 15

      true
    end

    # Parse NPWP into components.
    #
    # @param npwp [String]
    # @return [Hash]
    def parse(npwp)
      digits = npwp.gsub(/[^0-9]/, "")

      {
        raw: npwp,
        digits: digits,
        kpp_code: digits[0..1],
        serial: digits[2..7],
        type: digits[8],
        check: digits[9],
        branch: digits[10..12],
        formatted: format_npwp(digits),
        corporate: digits[8] == "9",
      }
    end

    # Format digits into standard NPWP format.
    #
    # @param digits [String] 15-digit string
    # @return [String] e.g. "12.345.678.9-012.000"
    def format_npwp(digits)
      "#{digits[0..1]}.#{digits[2..4]}.#{digits[5..7]}.#{digits[8]}-#{digits[9..11]}.#{digits[12..14]}"
    end
  end
end
