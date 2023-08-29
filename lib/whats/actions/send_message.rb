# frozen_string_literal: true

module Whats
  module Actions
    class SendMessage
      PATH = "/v17.0/%{phone_id}/messages"

      def initialize(client, wa_id, body, phone_id)
        @client = client
        @wa_id  = wa_id
        @body   = body
        @path   = URI::DEFAULT_PARSER.escape(PATH % {phone_id: phone_id})
      end

      def call
        client.request @path, payload
      end

      private

      attr_reader :client, :wa_id, :body

      def payload
        {
          messaging_product: "whatsapp",
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

