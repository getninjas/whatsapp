# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "whats/version"

Gem::Specification.new do |spec|
  spec.name    = "whatsapp"
  spec.version = Whats::VERSION
  spec.authors = ["Bruno Soares", "GetNinjas"]
  spec.email   = ["bruno@bsoares.com", "tech@getninjas.com.br"]

  spec.description = spec.summary = "An interface to WhatsApp Enterprise API."
  spec.homepage    = "https://github.com/getninjas/whatsapp"
  spec.license     = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock"

  spec.add_dependency "typhoeus"
end
