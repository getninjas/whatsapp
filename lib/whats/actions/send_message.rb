# frozen_string_literal: true

module Whats
  module Actions
    class SendMessage
      PATH = "/api/rest_send.php"

      def initialize(client, username, body)
        @client   = client
        @username = username
        @body     = body
      end

      def call
        client.request PATH, payload
      end

      private

      attr_reader :client, :username, :body

      def payload
        {
          payload: {
            to:   username,
            body: body
          }
        }
      end
    end
  end
end
