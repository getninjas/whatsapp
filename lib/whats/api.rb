# frozen_string_literal: true

require "whats/actions/check_contacts"
require "whats/actions/send_message"
require "whats/actions/send_hsm_message"

module Whats
  class Api
    def initialize
      @base_path = Whats.configuration.base_path
    end

    def check_contacts(numbers)
      Actions::CheckContacts.new(client, numbers).call
    end

    def check_contact(number)
      response = check_contacts([number])
      if response["errors"]
        raise Whats::Errors::RequestError.new("WhatsApp error.", response)
      end

      result = \
        response["contacts"].reduce({}) do |temp, hash|
          temp.merge(hash["input"] => hash)
        end

      result[number]
    end

    def send_message(username, body)
      Actions::SendMessage.new(client, username, body).call
    end

    def send_hsm_message(username, namespace, element_name, language, params)
      Actions::SendHsmMessage.new(
        client,
        username,
        namespace,
        element_name,
        language,
        params
      ).call
    end

    private

    attr_reader :base_path

    def client
      @client ||= Whats::Client.new
    end
  end
end
