# frozen_string_literal: true

module Whats
  module Errors
    class RequestError < StandardError
      attr_reader :response

      def initialize(message, response = nil)
        super message

        @response = response
      end
    end
  end
end
