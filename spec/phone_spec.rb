# frozen_string_literal: true

RSpec.describe NikParser::Phone do
  describe ".valid?" do
    it "returns true for valid phone" do
      expect(described_class.valid?("081234567890")).to be true
    end

    it "returns true for +62 format" do
      expect(described_class.valid?("+6281234567890")).to be true
    end

    it "returns true for 62 format" do
      expect(described_class.valid?("6281234567890")).to be true
    end

    it "returns false for invalid prefix" do
      expect(described_class.valid?("06123456789")).to be false
    end

    it "returns false for unknown prefix" do
      expect(described_class.valid?("08001234567")).to be false
    end

    it "returns false for non-string" do
      expect(described_class.valid?(8123456789)).to be false
    end
  end

  describe ".normalize" do
    it "normalizes +62 to 0" do
      expect(described_class.normalize("+6281234567890")).to eq("081234567890")
    end

    it "normalizes 62 to 0" do
      expect(described_class.normalize("6281234567890")).to eq("081234567890")
    end

    it "keeps 08xx as is" do
      expect(described_class.normalize("081234567890")).to eq("081234567890")
    end
  end
end
