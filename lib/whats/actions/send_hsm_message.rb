# typed: strict
# frozen_string_literal: true

module Whats
  module Actions
    class SendHsmMessage
      extend T::Sig

      PATH = "/v1/messages"

      sig do
        params(
          client: Whats::Client,
          wa_id: String,
          namespace: String,
          element_name: String,
          params: T::Hash[T.untyped, T.untyped]
        ).void
      end
      def initialize(client, wa_id, namespace, element_name, params)
        @client       = T.let(client, Whats::Client)
        @wa_id        = T.let(wa_id, String)
        @namespace    = T.let(namespace, String)
        @element_name = T.let(element_name, String)
        @params       = T.let(params, T::Hash[T.untyped, T.untyped])
      end

      sig { returns(T::Hash[T.untyped, T.untyped]) }
      def call
        client.request PATH, payload
      end

      private

      sig { returns(Whats::Client) }
      attr_reader :client

      sig { returns(String) }
      attr_reader :wa_id, :namespace, :element_name

      sig { returns(T::Hash[T.untyped, T.untyped]) }
      attr_reader :params

      sig { returns(T::Hash[T.untyped, T.untyped]) }
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
