lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require './lib/stock-research/version'

Gem::Specification.new do |spec|
  spec.authors       = ["Frank Nowinski & Roberto Mesado"]
  spec.email         = ["fpnowinski@gmail.com, rob.rsocial@gmail.com"]
  spec.description   = %q{Downloads stock profiles.}
  spec.summary       = %q{Downloads stock profiles.}
  spec.homepage      = "https://learn.co"

  spec.files         = ["lib/stock-research/cli"], ["lib/stock-research/get_quote"], ["lib/stock-research/version"], ["lib/stock-research/stock-research"]
  spec.executables   = ["stock-research"]
#  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.name          = "stock-research-cli-gem"
  spec.require_paths = ["lib", "lib/stock-research"]
  spec.version       = StockResearch::VERSION
  spec.license       = "MIT"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "csv"
  spec.add_development_dependency "open-uri"

end