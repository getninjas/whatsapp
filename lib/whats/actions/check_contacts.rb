# frozen_string_literal: true

module Whats
  module Actions
    class CheckContacts
      PATH = "/v1/contacts"

      def initialize(client, contacts)
        @client  = client
        @contacts = contacts
      end

      def call
        client.request PATH, payload
      end

      private

      attr_reader :client, :contacts

      def payload
        {
          blocking: "wait",
          contacts: contacts
        }
      end
    end
  end
end
