# frozen_string_literal: true

require_relative "fixture_helper"

module WebmockHelper
  include FixtureHelper

  BASE_PATH          = "http://test.local"
  CHECK_CONTACTS_URL = "#{BASE_PATH}#{Whats::Actions::CheckContacts::PATH}"
  SEND_MESSAGE_URL   = "#{BASE_PATH}#{Whats::Actions::SendHsmMessage::PATH}"
  LOGIN_URL          = "#{BASE_PATH}#{Whats::Actions::Login::PATH}"

  def stub_check_contacts_with_valid_number(contact, wa_id)
    stub_default(
      CHECK_CONTACTS_URL,
      request_body: check_contacts_request(contact: contact),
      response_body: check_contacts_response(input: contact, wa_id: wa_id)
    )
  end

  def stub_check_contacts_with_valid_numbers(contacts, wa_ids)
    stub_default(
      CHECK_CONTACTS_URL,
      request_body: check_multiple_contacts_request(contacts: contacts),
      response_body: check_multiple_contacts_response(
        inputs: contacts, wa_ids: wa_ids
      )
    )
  end

  def stub_check_contacts_with_invalid_number(contact)
    stub_default(
      CHECK_CONTACTS_URL,
      request_body: check_contacts_request(contact: contact),
      response_body: check_contacts_response_invalid(input: contact)
    )
  end

  def stub_send_message_with_valid_response(username, body)
    stub_default(
      SEND_MESSAGE_URL,
      request_body: send_message_request(username: username, body: body),
      response_body: message_sent_response
    )
  end

  def stub_send_message_with_unknown_contact_response(username, body)
    stub_default(
      SEND_MESSAGE_URL,
      request_body: send_message_request(username: username, body: body),
      response_body: message_sent_with_unknown_contact_response
    )
  end

  def stub_send_message_with_empty_wa_id_response(body)
    stub_default(
      SEND_MESSAGE_URL,
      request_body: send_message_request(username: "", body: body),
      response_body: message_sent_with_empty_wa_id_response
    )
  end

  def stub_send_message_with_empty_body_response(username)
    stub_default(
      SEND_MESSAGE_URL,
      request_body: send_message_request(username: username, body: ""),
      response_body: message_sent_with_empty_body_response
    )
  end

  def stub_send_hsm_message(username, namespace, element_name, language, params: {})
    stub_default(
      SEND_MESSAGE_URL,
      request_body: send_hsm_message_request(
        username:     username,
        namespace:    namespace,
        element_name: element_name,
        language:     language,
        params:       params
      ),
      response_body: message_sent_response
    )
  end

  def stub_send_hsm_message_with_unknown_contact_response(username, namespace, element_name, language, params: {})
    stub_default(
      SEND_MESSAGE_URL,
      request_body: send_hsm_message_request(
        username:     username,
        namespace:    namespace,
        element_name: element_name,
        language:     language,
        params:       params
      ),
      response_body: message_sent_with_unknown_contact_response
    )
  end

  def stub_login(token, credential)
    stub_default(
      LOGIN_URL,
      request_body: "",
      response_body: login_response(token),
      headers: { "Authorization" => "Basic dXNlcm5hbWU6c2VjcmV0X3Bhc3N3b3Jk" }
    )
  end

  def stub_default(url, method: :post, request_body:, response_body:, status: 200, headers: { "Content-Type" => "application/json" })
    stub = stub_request(method, url)
      .with(
        body: request_body,
        headers: headers
      )
      .to_return(
        body: response_body,
        status: status
      )

    print_stub(stub) if ENV["PRINT_STUBS"] == "true"
  end

  def print_stub(stub)
    puts "+ ------ STUB ------"
    puts "+ Request:  #{stub.request_pattern}"
    puts "+ Response: #{stub.response.body}"
    puts "+ ------------------"
  end
end
