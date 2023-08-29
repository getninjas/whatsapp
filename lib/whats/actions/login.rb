# frozen_string_literal: true

require "base64"

module Whats
  module Actions
    class Login
      PATH = "/v1/users/login"

      def initialize
        @client = Whats::Client.new(encoded_auth, :basic)
      end

      def call
        client.request(PATH)
      end

      def token
        return @token if valid?

        extract_atributes call

        @token
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
