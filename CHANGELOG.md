# Changelog

All notable changes to this project will be documented in this file.

## [0.1.0] - 2026-06-28

### Changed
- Complete rewrite with proper Ruby gem structure
- Module namespace: `NikParser::NIK`, `NikParser::Validator`, etc.
- Cached regional data (no more File.open on every parse)
- RSpec test suite with full coverage
- GitHub Actions CI (Ruby 3.0–3.4)

### Added
- NIK validation (format, region codes, day/month checks)
- NPWP validation and parsing
- Indonesian phone number validation
- Rupiah formatting and parsing
- `NikParser.valid_nik?`, `NikParser.valid_npwp?`, `NikParser.valid_phone?`, `NikParser.rupiah`
- `NikParser::Region` for regional data access

## [0.0.1] - 2019-12-25

### Added
- Initial release: basic NIK parsing
