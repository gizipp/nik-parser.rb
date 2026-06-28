# frozen_string_literal: true

require_relative "lib/nik_parser/version"

Gem::Specification.new do |spec|
  spec.name          = "nik-parser"
  spec.version       = NikParser::VERSION
  spec.authors       = ["Gilang R. Aprianto"]
  spec.email         = ["gilang@gizipp.com"]

  spec.summary       = "Indonesian identity toolkit. Parse NIK, validate NPWP, phone, format Rupiah."
  spec.description   = <<~DESC
    Indonesian identity toolkit for Ruby. Parse NIK (Nomor Induk Kependudukan),
    validate NPWP and phone numbers, format Rupiah. Includes comprehensive
    regional data for all Indonesian provinces, regencies, and districts.
  DESC
  spec.homepage      = "https://github.com/gizipp/nik-parser.rb"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"]    = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"]   = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?("spec/", "test/", ".github/", "bin/", ".")
    end
  end

  spec.require_paths = ["lib"]
end
