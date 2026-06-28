# frozen_string_literal: true

module NikParser
  # Indonesian phone number validation and formatting.
  module Phone
    # Known Indonesian carrier prefixes (08xx).
    PREFIXES = %w[
      0811 0812 0813 0821 0822 0823
      0851 0852 0853
      0814 0815 0816
      0817 0818 0819
      0855 0856 0857 0858 0859
      0877 0878
      0895 0896 0897 0898 0899
      0881 0882 0883 0884 0885 0886 0887 0888 0889
    ].freeze

    module_function

    # Validate Indonesian phone number.
    #
    # Accepts formats: 08xx, +628xx, 628xx
    # Length: 10-13 digits (excluding country code)
    #
    # @param phone [String]
    # @return [Boolean]
    def valid?(phone)
      return false unless phone.is_a?(String)

      digits = normalize(phone)
      return false unless digits.match?(/\A08\d{8,11}\z/)

      # Check known prefix
      prefix4 = digits[0..3]
      PREFIXES.include?(prefix4)
    end

    # Normalize phone to local format (08xx).
    #
    # @param phone [String]
    # @return [String]
    def normalize(phone)
      digits = phone.gsub(/[^0-9]/, "")

      # +62 or 62 prefix -> 0
      if digits.start_with?("62")
        digits = "0#{digits[2..]}"
      end

      digits
    end

    # Format with country code (+62).
    #
    # @param phone [String]
    # @return [String] e.g. "+62 812-3456-7890"
    def format_international(phone)
      digits = normalize(phone)
      local = digits[1..] # strip leading 0

      "+62 #{local[0..2]}-#{local[3..6]}-#{local[7..]}"
    end
  end
end
