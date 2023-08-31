# frozen_string_literal: true

require "whats/actions/check_contacts"
require "whats/actions/send_message"
require "whats/actions/mark_read"

module Whats
  class Api
    def initialize
      @base_path = Whats.configuration.base_path
      @token = Whats.configuration.token
      @phone_id = Whats.configuration.phone_id
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

    def send_message(to, type, body)
      Actions::SendMessage.new(client, to, @phone_id, type, body).call
    end

    def mark_read(message_id)
      Actions::MarkRead.new(client, message_id, @phone_id).call
    end

    private

    attr_reader :base_path

    def client
      @client ||= Whats::Client.new(@token)
    end
  end
end
