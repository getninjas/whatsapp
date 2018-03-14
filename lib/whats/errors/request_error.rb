# frozen_string_literal: true

module Whats
  module Errors
    class RequestError < StandardError
      attr_reader :response

      def initialize(message, response)
        @response = response

        super message
      end
    end
  end
end
