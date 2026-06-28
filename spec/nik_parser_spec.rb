# frozen_string_literal: true

RSpec.describe NikParser do
  it "has a version" do
    expect(NikParser::VERSION).not_to be_nil
  end

  describe ".parse" do
    it "returns a NIK object" do
      nik = NikParser.parse("3204110609970004")
      expect(nik).to be_a(NikParser::NIK)
    end
  end

  describe ".valid_nik?" do
    it "returns true for valid NIK" do
      expect(NikParser.valid_nik?("3204110609970004")).to be true
    end
  end

  describe ".valid_npwp?" do
    it "returns true for valid NPWP" do
      expect(NikParser.valid_npwp?("12.345.678.9-012.000")).to be true
    end
  end

  describe ".valid_phone?" do
    it "returns true for valid phone" do
      expect(NikParser.valid_phone?("081234567890")).to be true
    end
  end

  describe ".rupiah" do
    it "formats as Rupiah" do
      expect(NikParser.rupiah(1500000)).to eq("Rp 1.500.000")
    end
  end
end
