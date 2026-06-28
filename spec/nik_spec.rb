# frozen_string_literal: true

RSpec.describe NikParser::NIK do
  describe "#valid?" do
    it "returns true for valid NIK" do
      nik = described_class.new("3204110609970004")
      expect(nik.valid?).to be true
    end

    it "returns false for NIK with invalid province code" do
      nik = described_class.new("9904110609970004")
      expect(nik.valid?).to be false
    end
  end

  describe "#province" do
    it "returns province name" do
      nik = described_class.new("3204110609970004")
      expect(nik.province).to eq("JAWA BARAT")
    end

    it "returns province code" do
      nik = described_class.new("3204110609970004")
      expect(nik.province_code).to eq("32")
    end
  end

  describe "#regency" do
    it "returns regency name" do
      nik = described_class.new("3204110609970004")
      expect(nik.regency).to eq("KAB. BANDUNG")
    end
  end

  describe "#district" do
    it "returns district name" do
      nik = described_class.new("3204110609970004")
      expect(nik.district).to eq("KATAPANG")
    end
  end

  describe "#sex" do
    it "returns M for male NIK" do
      nik = described_class.new("3204110609970004")
      expect(nik.sex).to eq("M")
    end

    it "returns F for female NIK" do
      nik = described_class.new("3204114609970004")
      expect(nik.sex).to eq("F")
    end
  end

  describe "#birth_day" do
    it "returns birth day for male" do
      nik = described_class.new("3204110609970004")
      expect(nik.birth_day).to eq(6)
    end

    it "returns birth day for female (code - 40)" do
      nik = described_class.new("3204114609970004")
      expect(nik.birth_day).to eq(6)
    end
  end

  describe "#birth_month" do
    it "returns birth month" do
      nik = described_class.new("3204110609970004")
      expect(nik.birth_month).to eq(9)
    end
  end

  describe "#birth_year" do
    it "returns birth year" do
      nik = described_class.new("3204110609970004")
      expect(nik.birth_year).to eq(1997)
    end
  end

  describe "#birthdate" do
    it "returns ISO 8601 date" do
      nik = described_class.new("3204110609970004")
      expect(nik.birthdate).to eq("1997-09-06")
    end
  end

  describe "#unique_code" do
    it "returns last 4 digits" do
      nik = described_class.new("3204110609970004")
      expect(nik.unique_code).to eq("0004")
    end
  end

  describe "#to_h" do
    it "returns hash representation" do
      nik = described_class.new("3204110609970004")
      hash = nik.to_h

      expect(hash[:nik]).to eq("3204110609970004")
      expect(hash[:region][:province]).to eq("JAWA BARAT")
      expect(hash[:sex]).to eq("M")
      expect(hash[:birth][:year]).to eq("1997")
    end
  end

  describe "errors" do
    it "raises InvalidNIK for nil" do
      expect { described_class.new(nil) }.to raise_error(NikParser::InvalidNIK)
    end

    it "raises InvalidNIK for empty string" do
      expect { described_class.new("") }.to raise_error(NikParser::InvalidNIK)
    end

    it "raises InvalidNIK for wrong length" do
      expect { described_class.new("12345") }.to raise_error(NikParser::InvalidNIK)
    end
  end
end
