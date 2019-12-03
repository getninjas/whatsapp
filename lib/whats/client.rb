# frozen_string_literal: true

require "whats/actions/login"

module Whats
  class Client
    def initialize(token = nil, token_type = :bearer)
      @base_path = Whats.configuration.base_path
      @token = token || login.token
      @token_type = token_type
    end

    def request(path, payload = nil)
      full_path = "#{base_path}#{path}"

      response = Typhoeus.post(
        full_path,
        headers: {
          "Authorization" => "#{token_name} #{token}",
          "Content-Type" => "application/json"
        },
        body: payload && payload.to_json
      )

      raise Whats::Errors::RequestError.new("API request error.", response) if response.failure?

      JSON.parse(response.response_body)
    end

    private

    attr_reader :base_path, :token, :token_type

    def token_name
      case token_type
      when :basic
        "Basic"
      when :bearer
        "Bearer"
      end
    end

    def login
      Whats::Actions::Login.new
    end
  end
end
