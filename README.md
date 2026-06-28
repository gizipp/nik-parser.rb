# nik-parser

[![Gem Version](https://badge.fury.io/rb/nik-parser.svg)](https://badge.fury.io/rb/nik-parser)
[![CI](https://github.com/gizipp/nik-parser.rb/actions/workflows/ci.yml/badge.svg)](https://github.com/gizipp/nik-parser.rb/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Indonesian identity toolkit for Ruby. Parse NIK, validate NPWP, phone numbers, and format Rupiah.

## Installation

```ruby
gem "nik-parser"
```

```
$ gem install nik-parser
```

## Quick Start

```ruby
require "nik_parser"

# Parse NIK
nik = NikParser.parse("3204110609970004")
nik.province    # => "JAWA BARAT"
nik.regency     # => "KAB. BANDUNG"
nik.district    # => "KATAPANG"
nik.sex         # => "M"
nik.birthdate   # => "1997-09-06"

# Validate
NikParser.valid_nik?("3204110609970004")   # => true
NikParser.valid_npwp?("12.345.678.9-012.000")  # => true
NikParser.valid_phone?("081234567890")     # => true

# Format Rupiah
NikParser.rupiah(1500000)  # => "Rp 1.500.000"
```

## Features

### NIK (Nomor Induk Kependudukan)

```ruby
nik = NikParser::NIK.new("3204110609970004")

nik.valid?        # => true
nik.province      # => "JAWA BARAT"
nik.province_code # => "32"
nik.regency       # => "KAB. BANDUNG"
nik.district      # => "KATAPANG"
nik.sex           # => "M" / "F"
nik.birth_day     # => 6
nik.birth_month   # => 9
nik.birth_year    # => 1997
nik.birthdate     # => "1997-09-06"
nik.unique_code   # => "0004"
nik.to_h          # => { nik: "...", region: {...}, sex: "M", birth: {...} }
```

### NPWP (Nomor Pokok Wajib Pajak)

```ruby
NikParser.valid_npwp?("12.345.678.9-012.000")  # => true

npwp = NikParser::NPWP.parse("12.345.678.9-012.000")
npwp[:kpp_code]   # => "12"
npwp[:corporate]  # => true (type 9)
npwp[:branch]     # => "000"
npwp[:formatted]  # => "12.345.678.9-012.000"
```

### Phone Number

```ruby
NikParser.valid_phone?("081234567890")    # => true
NikParser.valid_phone?("+6281234567890")  # => true

NikParser::Phone.normalize("+6281234567890")           # => "081234567890"
NikParser::Phone.format_international("081234567890")  # => "+62 812-3456-7890"
```

### Rupiah

```ruby
NikParser.rupiah(1500000)                       # => "Rp 1.500.000"
NikParser::Rupiah.format(1500000, symbol: false) # => "1.500.000"
NikParser::Rupiah.parse("Rp 1.500.000")         # => 1500000
```

## Regional Data

Includes data for all Indonesian provinces, regencies, and districts. Data is loaded once and cached.

```ruby
NikParser::Region.provinces  # => { "11" => "ACEH", "12" => "SUMATERA UTARA", ... }
NikParser::Region.province("33")     # => "JAWA TENGAH"
NikParser::Region.regency("33.74")   # => "KOTA SEMARANG"
```

## Related

Part of the **Nusantara** Indonesian toolkit ecosystem:

- [nik-parser](https://github.com/gizipp/nik-parser.rb) — Ruby (this gem)
- [nusantara](https://github.com/gizipp/nusantara) — JavaScript/TypeScript (npm)
- [nusantara-php](https://github.com/gizipp/nusantara-php) — PHP (Composer)

## Development

```bash
git clone https://github.com/gizipp/nik-parser.rb.git
cd nik-parser.rb
bundle install
bundle exec rspec
```

## License

[MIT](LICENSE)
