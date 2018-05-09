# frozen_string_literal: true

module Whats
  module Actions
    class CheckContacts
      PATH = "/v1/contacts"

      def initialize(client, numbers)
        @client  = client
        @numbers = numbers
      end

      def call
        client.request PATH, payload
      end

      private

      attr_reader :client, :numbers

      def payload
        {
          payload: {
            blocking: "wait",
            users:    numbers
          }
        }
      end
    end
  end
end
