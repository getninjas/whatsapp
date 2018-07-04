# frozen_string_literal: true

module Whats
  module Actions
    class SendHsmMessage
      PATH = "/v1/messages"

      def initialize(client, wa_id, namespace, element_name, params)
        @client       = client
        @wa_id        = wa_id
        @namespace    = namespace
        @element_name = element_name
        @params       = params
      end

      def call
        client.request PATH, payload
      end

      private

      attr_reader :client, :wa_id, :namespace, :element_name, :params

      def payload
        {
          hsm: {
            element_name: element_name,
            language: {
              code: :pt_BR,
              policy: :deterministic
              },
            localizable_params: params,
            namespace: namespace
          },
          recipient_type: :individual,
          to: wa_id,
          type: :hsm
        }
      end
    end
  end
end
