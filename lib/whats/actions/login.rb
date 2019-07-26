# typed: strict
# frozen_string_literal: true

require "base64"

module Whats
  module Actions
    class Login
      extend T::Sig

      PATH = "/v1/users/login"

      sig { void }
      def initialize
        @user = T.let(Whats.configuration.user, String)
        @password = T.let(Whats.configuration.password, String)

        @token = T.let(nil, T.nilable(String))
        @expires_after = T.let(nil, T.nilable(String))
      end

      sig { returns(String) }
      def token
        return T.cast(@token, String) if valid?

        full_path = "#{Whats.configuration.base_path}#{PATH}"

        response = Typhoeus.post(
          full_path,
          headers: { "Authorization" => "Basic #{encoded_auth}" },
          body: {}
        )
        update_atributes response

        T.cast(@token, String)
      end

      private

      sig { params(response: Typhoeus::Response).void }
      def update_atributes(response)
        if response.failure?
          raise Whats::Errors::RequestError.new("API request error.", response)
        end

        response = JSON.parse response.body

        @token = response["users"].first["token"]
        @expires_after = response["users"].first["expires_after"]
      end

      sig { returns(String) }
      def encoded_auth
        Base64.encode64("#{@user}:#{@password}").chomp
      end

      sig { returns(T::Boolean) }
      def valid?
        return false if @expires_after.nil?

        @expires_after > Time.now
      end
    end
  end
end
