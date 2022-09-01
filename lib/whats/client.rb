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

      conn = Faraday.new(url: full_path, headers: headers)
      response = conn.post { |request| request.body = body(payload) }

      raise Whats::Errors::RequestError.new("API request error.", response) unless response.success?

      JSON.parse(response.body)
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

    def headers
      {
        "Authorization" => "#{token_name} #{token}",
        "Content-Type" => "application/json",
      }
    end

    def body(payload)
      payload && payload.to_json
    end
  end
end
