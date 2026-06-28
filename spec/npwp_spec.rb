# frozen_string_literal: true

RSpec.describe NikParser::NPWP do
  describe ".valid?" do
    it "returns true for valid NPWP" do
      expect(described_class.valid?("12.345.678.9-012.000")).to be true
    end

    it "returns true for digits only" do
      expect(described_class.valid?("123456789012000")).to be true
    end

    it "returns false for wrong length" do
      expect(described_class.valid?("12345")).to be false
    end

    it "returns false for non-string" do
      expect(described_class.valid?(12345)).to be false
    end
  end

  describe ".parse" do
    it "parses NPWP components" do
      result = described_class.parse("12.345.678.9-012.000")

      expect(result[:kpp_code]).to eq("12")
      expect(result[:serial]).to eq("345678")
      expect(result[:type]).to eq("9")
      expect(result[:corporate]).to be true
      expect(result[:branch]).to eq("120")
      expect(result[:formatted]).to eq("12.345.678.9-012.000")
    end
  end
end
