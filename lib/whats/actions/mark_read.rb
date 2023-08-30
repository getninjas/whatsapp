# frozen_string_literal: true

module Whats
  module Actions
    class MarkRead
      PATH = "/v17.0/%{phone_id}/messages"

      def initialize(client, message_id, phone_id)
        @client = client
        @message_id  = message_id
        @path   = URI::DEFAULT_PARSER.escape(PATH % {phone_id: phone_id})
      end

      def call
        client.request @path, payload
      end

      private

      attr_reader :client, :message_id

      def payload
        {
          messaging_product: "whatsapp",
          status: "read",
          message_id: message_id
        }
      end
    end
  end
end

