# typed: strict

module Whats
  module Actions
    class SendMessage
      sig { params(client: Whats::Client, wa_id: String, body: String).void }
      def initialize(client, wa_id, body); end

      sig { returns(T::Hash[T.untyped, T.untyped]) }
      def call; end
    end

    class SendHsmMessage
      sig do
         params(
           client: Whats::Client,
           wa_id: String,
           namespace: String,
           element_name: String,
           params: T::Hash[T.untyped, T.untyped]
         ).void
       end
       def initialize(client, wa_id, namespace, element_name, params); end

       sig { returns(T::Hash[T.untyped, T.untyped]) }
       def call; end
    end

    class Login
      sig { void }
      def initialize; end

      sig { returns(String) }
      def token; end
    end
  end
end
