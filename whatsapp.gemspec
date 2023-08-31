# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "whats/version"

Gem::Specification.new do |spec|
  spec.name        = "whatsapp"
  spec.version     = Whats::VERSION
  spec.authors     = ["Bruno Soares", "GetNinjas"]
  spec.email       = ["bruno@bsoares.com", "tech@getninjas.com.br"]
  spec.summary     = "WhatsApp Enterprise API interface."
  spec.description = "A Ruby interface to WhatsApp Enterprise API."
  spec.homepage    = "https://github.com/getninjas/whatsapp"
  spec.license     = "MIT"

  spec.files         = Dir["lib/**/*"]
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday_middleware-aws-sigv4", "~> 0.5.0"

  spec.add_development_dependency "bundler",                   "~> 2.4"
  spec.add_development_dependency "pry-byebug",                "~> 3.6"
  spec.add_development_dependency "rake",                      "~> 10.0"
  spec.add_development_dependency "rspec",                     "~> 3.0"
  spec.add_development_dependency "rubocop",                   "~> 0.53"
  spec.add_development_dependency "rubocop-github",            "~> 0.10"
  spec.add_development_dependency "rubocop-rspec",             "~> 1.24"
  spec.add_development_dependency "simplecov",                 "~> 0.16"
  spec.add_development_dependency "simplecov-console",         "~> 0.4"
  spec.add_development_dependency "webmock",                   "~> 3.3"
end
