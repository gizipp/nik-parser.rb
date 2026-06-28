# frozen_string_literal: true

module NikParser
  # Represents a parsed Indonesian NIK (Nomor Induk Kependudukan).
  #
  # @example
  #   nik = NikParser::NIK.new("3204110609970004")
  #   nik.province  # => "JAWA BARAT"
  #   nik.sex       # => "M"
  #   nik.birthdate # => "1997-09-06"
  #
  class NIK
    attr_reader :raw

    # @param nik [String] 16-digit NIK string
    def initialize(nik)
      raise InvalidNIK, "NIK cannot be nil" if nik.nil?
      raise InvalidNIK, "NIK cannot be empty" if nik.to_s.strip.empty?

      @raw = nik.to_s.strip
      @digits = @raw.gsub(/[^0-9]/, "")

      raise InvalidNIK, "NIK must be 16 digits" unless @digits.length == 16
    end

    # Whether this NIK passes all validation checks.
    #
    # @return [Boolean]
    def valid?
      Validator.valid_nik?(@digits)
    end

    # 2-digit province code.
    #
    # @return [String]
    def province_code
      @digits[0..1]
    end

    # Province name.
    #
    # @return [String, nil]
    def province
      Region.province(province_code)
    end

    # 4-digit regency code.
    #
    # @return [String]
    def regency_code
      @digits[0..3]
    end

    # Regency name.
    #
    # @return [String, nil]
    def regency
      Region.regency(regency_code)
    end

    # 6-digit district code.
    #
    # @return [String]
    def district_code
      @digits[0..5]
    end

    # District name.
    #
    # @return [String, nil]
    def district
      Region.district(district_code)
    end

    # Sex: "M" or "F".
    #
    # Female NIK has day code > 40 (day = code - 40).
    #
    # @return [String]
    def sex
      @digits[6..7].to_i > 40 ? "F" : "M"
    end

    # Day of birth.
    #
    # @return [Integer]
    def birth_day
      code = @digits[6..7].to_i
      code > 40 ? code - 40 : code
    end

    # Month of birth (1-12).
    #
    # @return [Integer]
    def birth_month
      @digits[8..9].to_i
    end

    # Year of birth.
    #
    # Uses current year as reference: if 2-digit year <= current 2-digit year,
    # assume 2000s; otherwise 1900s.
    #
    # @return [Integer]
    def birth_year
      two_digit = @digits[10..11].to_i
      current_two_digit = Time.now.year % 100

      two_digit <= current_two_digit ? 2000 + two_digit : 1900 + two_digit
    end

    # Birthdate as ISO 8601 string.
    #
    # @return [String] e.g. "1997-09-06"
    def birthdate
      format("%04d-%02d-%02d", birth_year, birth_month, birth_day)
    end

    # Unique sequence code (last 4 digits).
    #
    # @return [String]
    def unique_code
      @digits[12..15]
    end

    # Full NIK digits.
    #
    # @return [String]
    def to_s
      @digits
    end

    def to_h
      {
        nik: @digits,
        region: {
          province: province,
          regency: regency,
          district: district,
        },
        sex: sex,
        birth: {
          date: format("%02d", birth_day),
          month: format("%02d", birth_month),
          year: birth_year.to_s,
        },
        unique_code: unique_code,
      }
    end

    def inspect
      "#<NikParser::NIK nik=#{@digits} province=#{province} valid=#{valid?}>"
    end
  end
end
