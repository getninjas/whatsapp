# frozen_string_literal: true

module Whats
  module Actions
    class SendHsmMessage
      PATH = "/v1/messages"

      def initialize(client, wa_id, namespace, element_name, language, params)
        @client       = client
        @wa_id        = wa_id
        @namespace    = namespace
        @element_name = element_name
        @language     = language
        @params       = params
      end

      def call
        client.request PATH, payload
      end

      private

      attr_reader :client, :wa_id, :namespace, :element_name, :language, :params

      def payload
        {
          template: {
              name: element_name,
              language: language.is_a?(Hash) ? language : language_options(language),
              namespace: namespace,
              components: [{
                  type: :body,
                  parameters: params
              }]
          },
          recipient_type: :individual,
          to: wa_id,
          type: :template
        }
      end

      def language_options(language)
        {
          code: language,
          policy: :deterministic
        }
      end
    end
  end
end
