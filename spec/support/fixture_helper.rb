# frozen_string_literal: true

module FixtureHelper
  def load_json(path, variables = nil)
    data = File.read("spec/fixtures/#{path}.json")
    data = data % variables if variables
    JSON.parse(data).to_json
  end

  def check_contacts_request(contact:)
    load_json("check_contacts_request", contact: contact)
  end

  def check_contacts_response(input:, wa_id:)
    load_json("check_contacts_response", input: input, wa_id: wa_id)
  end

  def check_contacts_response_invalid(input:)
    load_json("check_contacts_response_invalid", input: input)
  end

  def check_multiple_contacts_request(contacts:)
    load_json(
      "check_multiple_contacts_request",
      contact_1: contacts[0],
      contact_2: contacts[1]
    )
  end

  def check_multiple_contacts_response(inputs:, wa_ids:)
    load_json(
      "check_multiple_contacts_response",
      input_1: inputs[0],
      input_2: inputs[1],
      wa_id_1: wa_ids[0],
      wa_id_2: wa_ids[1]
    )
  end

  def send_message_request(wa_id:, body:)
    load_json("send_message_request", WA_ID: wa_id, BODY: body)
  end

  def send_hsm_message_request(username:, namespace:, element_name:, language:, params: {})
    load_json(
      "send_hsm_message_request",
      USERNAME:     username,
      NAMESPACE:    namespace,
      ELEMENT_NAME: element_name,
      LANGUAGE:     language,
      PARAMS:       params.to_json
    )
  end

  def message_sent_response(message_id: "ID")
    load_json("message_sent_response", MESSAGE_ID: message_id)
  end

  def message_sent_with_unknown_contact_response
    load_json("message_sent_with_unknown_contact_response")
  end

  def message_sent_with_empty_wa_id_response
    load_json("message_sent_with_empty_wa_id_response")
  end

  def message_sent_with_empty_body_response
    load_json("message_sent_with_empty_body_response")
  end

  def mark_read_request(message_id = '')
    load_json("mark_read_request", MESSAGE_ID: message_id)
  end

  def mark_read_response
    load_json("mark_read_response")
  end

  def mark_read_invalid_response
    load_json("mark_read_invalid_response")
  end

  def login_response(token)
    load_json "login_response", token: token
  end
end
