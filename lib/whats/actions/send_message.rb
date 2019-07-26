# typed: true
# frozen_string_literal: true

module Whats
  module Actions
    class SendMessage
      PATH = "/v1/messages"

      def initialize(client, wa_id, body)
        @client = client
        @wa_id  = wa_id
        @body   = body
      end

      def call
        client.request PATH, payload
      end

      private

      attr_reader :client, :wa_id, :body

      def payload
        {
          recipient_type: "individual",
          to: wa_id,
          type: "text",
          text: {
            body: body
          }
        }
      end
    end
  end
end
