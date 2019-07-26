# typed: strict
# frozen_string_literal: true

module Whats
  module Actions
    class SendMessage
      extend T::Sig

      PATH = "/v1/messages"

      sig { params(client: Whats::Client, wa_id: String, body: String).void }
      def initialize(client, wa_id, body)
        @client = T.let(client, Whats::Client)
        @wa_id  = T.let(wa_id, String)
        @body   = T.let(body, String)
      end

      sig { returns(T::Hash[T.untyped, T.untyped]) }
      def call
        client.request PATH, payload
      end

      private

      sig { returns(Whats::Client) }
      attr_reader :client

      sig { returns(String) }
      attr_reader :wa_id, :body

      sig { returns(T::Hash[T.untyped, T.untyped]) }
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
