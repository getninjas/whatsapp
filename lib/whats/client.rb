# frozen_string_literal: true

module Whats
  class Client
    def initialize
      @base_path = Whats.configuration.base_path
    end

    def request(path, payload)
      full_path = "#{base_path}#{path}"

      response = Typhoeus.post(
        full_path,
        headers: { "Content-Type" => "application/json" },
        body: payload.to_json
      )

      raise Whats::Errors::RequestError.new("API request error.", response) if response.failure?

      JSON.parse(response.response_body)
    end

    private

    attr_reader :base_path
  end
end
