# frozen_string_literal: true

RSpec.describe NikParser::Validator do
  describe ".valid_nik?" do
    it "returns true for valid NIK" do
      expect(described_class.valid_nik?("3204110609970004")).to be true
    end

    it "returns false for non-string" do
      expect(described_class.valid_nik?(12345)).to be false
    end

    it "returns false for wrong length" do
      expect(described_class.valid_nik?("12345")).to be false
    end

    it "returns false for non-digits" do
      expect(described_class.valid_nik?("abcdefghijklmnop")).to be false
    end

    it "returns false for invalid province code" do
      expect(described_class.valid_nik?("9904110609970004")).to be false
    end

    it "returns false for invalid day code" do
      expect(described_class.valid_nik?("3204113209970004")).to be false
    end

    it "returns false for invalid month" do
      expect(described_class.valid_nik?("3204110613970004")).to be false
    end
  end
end
