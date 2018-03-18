# frozen_string_literal: true

module FixtureHelper
  def load_json(path, variables = nil)
    data = File.read("spec/fixtures/#{path}.json")
    data = data % variables if variables
    JSON.parse(data).to_json
  end

  def check_contacts_request(input_number:, blocking: "wait")
    load_json("check_contacts_request", INPUT_NUMBER: input_number, BLOCKING: blocking)
  end

  def check_contacts_response(input_number:, exists: true, username:)
    load_json("check_contacts_response", INPUT_NUMBER: input_number, EXISTS: exists, USERNAME: username)
  end

  def check_multiple_contacts_request(input_numbers:, blocking: "wait")
    load_json(
      "check_multiple_contacts_request",
      BLOCKING:       blocking,
      INPUT_NUMBER_1: input_numbers[0],
      INPUT_NUMBER_2: input_numbers[1]
    )
  end

  def check_multiple_contacts_response(input_numbers:, exists: [true, true], usernames:)
    load_json(
      "check_multiple_contacts_response",
      INPUT_NUMBER_1: input_numbers[0],
      INPUT_NUMBER_2: input_numbers[1],
      EXISTS_1:       exists[0],
      EXISTS_2:       exists[1],
      USERNAME_1:     usernames[0],
      USERNAME_2:     usernames[1]
    )
  end

  def send_message_request(username:, body:)
    load_json("send_message_request", USERNAME: username, BODY: body)
  end

  def send_hsm_message_request(username:, namespace:, element_name:, params: {})
    load_json(
      "send_hsm_message_request",
      USERNAME:     username,
      NAMESPACE:    namespace,
      ELEMENT_NAME: element_name,
      PARAMS:       params.to_json
    )
  end

  def message_sent_response(message_id: "ID")
    load_json("message_sent_response", MESSAGE_ID: message_id)
  end

  def message_sent_with_unknown_contact_response
    load_json("message_sent_with_unknown_contact_response")
  end

  def message_sent_with_empty_username_response
    load_json("message_sent_with_empty_username_response")
  end

  def message_sent_with_empty_body_response
    load_json("message_sent_with_empty_body_response")
  end
end
