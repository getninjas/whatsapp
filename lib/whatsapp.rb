# frozen_string_literal: true

# Dependencies
require "json"
require "faraday_middleware/aws_sigv4"

# Source
require "whats/configuration"
require "whats/version"
require "whats/errors/request_error"
require "whats/client"
require "whats/api"
