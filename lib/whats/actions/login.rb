# frozen_string_literal: true

require "base64"

module Whats
  module Actions
    class Login
      PATH = "/v1/users/login"

      def initialize
        @user = Whats.configuration.user
        @password = Whats.configuration.password
      end

      def token
        return @token if valid?

        full_path = "#{Whats.configuration.base_path}#{PATH}"

        response = Typhoeus.post(
          full_path,
          headers: { "Authorization" => "Bearer #{encoded_auth}" },
          body: {}
        )

        update_atributes response

        @token
      end

      private

      def update_atributes(response)
        if response.failure?
          raise Whats::Errors::RequestError.new("API request error.", response)
        end

        response = JSON.parse response.body

        @token = response["users"].first["token"]
        @expires_after = response["users"].first["expires_after"]
      end

      def encoded_auth
        Base64.encode64("#{@user}:#{@password}").chomp
      end

      def valid?
        return false if @expires_after.nil?

        @expires_after > Time.now
      end
    end
  end
end
