# frozen_string_literal: true

require_relative "nik_parser/version"
require_relative "nik_parser/region"
require_relative "nik_parser/validator"
require_relative "nik_parser/nik"
require_relative "nik_parser/npwp"
require_relative "nik_parser/phone"
require_relative "nik_parser/rupiah"

# Indonesian identity toolkit — parse NIK, validate NPWP, phone, format Rupiah.
#
# @example Parse NIK
#   nik = NikParser.parse("3204110609970004")
#   nik.province  # => "JAWA BARAT"
#   nik.sex       # => "M"
#
# @example Validate
#   NikParser.valid_nik?("3204110609970004")  # => true
#   NikParser.valid_npwp?("12.345.678.9-012.000")  # => true
#
module NikParser
  class Error < StandardError; end
  class InvalidNIK < Error; end
  class InvalidNPWP < Error; end

  # Parse a NIK string into a NIK object.
  #
  # @param nik [String] 16-digit NIK
  # @return [NIK]
  # @raise [InvalidNIK] if NIK is invalid
  def self.parse(nik)
    NIK.new(nik)
  end

  # Validate a NIK string.
  #
  # @param nik [String]
  # @return [Boolean]
  def self.valid_nik?(nik)
    Validator.valid_nik?(nik)
  end

  # Validate an NPWP string.
  #
  # @param npwp [String]
  # @return [Boolean]
  def self.valid_npwp?(npwp)
    NPWP.valid?(npwp)
  end

  # Validate an Indonesian phone number.
  #
  # @param phone [String]
  # @return [Boolean]
  def self.valid_phone?(phone)
    Phone.valid?(phone)
  end

  # Format a number as Rupiah.
  #
  # @param amount [Numeric]
  # @return [String]
  def self.rupiah(amount)
    Rupiah.format(amount)
  end
end
