# frozen_string_literal: true

module Whats
  module Actions
    class Login
      PATH = "/v1/users/login"

      def initialize(client)
        @client = client
        @token = nil
        @expires_after = nil
      end

      def call
        response = client.request(PATH)
        extract_atributes(response) unless @token
        @token
      end

      def token
        call
      end

      private

      attr_reader :client

      def extract_atributes(response)
        @token = response["users"].first["token"]
        @expires_after = response["users"].first["expires_after"]
      end

      def valid?
        return false if @expires_after.nil?

        @expires_after > Time.now
      end
    end
  end
end
