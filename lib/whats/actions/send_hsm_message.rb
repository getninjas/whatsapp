# frozen_string_literal: true

module Whats
  module Actions
    class SendHsmMessage
      PATH = "/v1/messages"

      def initialize(client, username, namespace, element_name, params)
        @client       = client
        @username     = username
        @namespace    = namespace
        @element_name = element_name
        @params       = params
      end

      def call
        client.request PATH, payload
      end

      private

      attr_reader :client, :username, :namespace, :element_name, :params

      def payload
        {
          payload: {
            to: username,
            hsm: {
              namespace:          namespace,
              element_name:       element_name,
              localizable_params: params
            }
          }
        }
      end
    end
  end
end
