# frozen_string_literal: true

RSpec.describe NikParser::Rupiah do
  describe ".format" do
    it "formats with symbol" do
      expect(described_class.format(1500000)).to eq("Rp 1.500.000")
    end

    it "formats without symbol" do
      expect(described_class.format(1500000, symbol: false)).to eq("1.500.000")
    end

    it "formats zero" do
      expect(described_class.format(0)).to eq("Rp 0")
    end

    it "formats negative" do
      expect(described_class.format(-500000)).to eq("Rp -500.000")
    end

    it "formats large number" do
      expect(described_class.format(1000000000)).to eq("Rp 1.000.000.000")
    end
  end

  describe ".parse" do
    it "parses Rupiah string" do
      expect(described_class.parse("Rp 1.500.000")).to eq(1500000)
    end

    it "parses without symbol" do
      expect(described_class.parse("1.500.000")).to eq(1500000)
    end

    it "parses plain number" do
      expect(described_class.parse("1500000")).to eq(1500000)
    end
  end
end
