# frozen_string_literal: true

require "whats/actions/login"

module Whats
  class Client
    def initialize(login = Whats::Actions::Login.new)
      @base_path = Whats.configuration.base_path
      @login = login
    end

    def request(path, payload)
      full_path = "#{base_path}#{path}"

      response = Typhoeus.post(
        full_path,
        headers: {
          "Authorization" => "Bearer #{login.token}",
          "Content-Type" => "application/json"
        },
        body: payload.to_json
      )

      raise Whats::Errors::RequestError.new("API request error.", response) if response.failure?

      JSON.parse(response.response_body)
    end

    private

    attr_reader :base_path, :login
  end
end
