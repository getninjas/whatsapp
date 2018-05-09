# frozen_string_literal: true

require_relative "fixture_helper"

module WebmockHelper
  include FixtureHelper

  BASE_PATH          = "http://test.local"
  CHECK_CONTACTS_URL = "#{BASE_PATH}#{Whats::Actions::CheckContacts::PATH}"
  SEND_MESSAGE_URL   = "#{BASE_PATH}#{Whats::Actions::SendHsmMessage::PATH}"

  def stub_check_contacts_with_valid_number(input_number, username)
    stub_default(
      CHECK_CONTACTS_URL,
      request_body: check_contacts_request(input_number: input_number),
      response_body: check_contacts_response(input_number: input_number, username: username)
    )
  end

  def stub_check_contacts_with_valid_numbers(input_numbers, usernames)
    stub_default(
      CHECK_CONTACTS_URL,
      request_body: check_multiple_contacts_request(input_numbers: input_numbers),
      response_body: check_multiple_contacts_response(input_numbers: input_numbers, usernames: usernames)
    )
  end

  def stub_check_contacts_with_invalid_number(input_number)
    stub_default(
      CHECK_CONTACTS_URL,
      request_body: check_contacts_request(input_number: input_number),
      response_body: check_contacts_response(input_number: input_number, exists: false, username: "invalid")
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

  def stub_send_message_with_empty_username_response(body)
    stub_default(
      SEND_MESSAGE_URL,
      request_body: send_message_request(username: "", body: body),
      response_body: message_sent_with_empty_username_response
    )
  end

  def stub_send_message_with_empty_body_response(username)
    stub_default(
      SEND_MESSAGE_URL,
      request_body: send_message_request(username: username, body: ""),
      response_body: message_sent_with_empty_body_response
    )
  end

  def stub_send_hsm_message(username, namespace, element_name, params: {})
    stub_default(
      SEND_MESSAGE_URL,
      request_body: send_hsm_message_request(
        username:     username,
        namespace:    namespace,
        element_name: element_name,
        params:       params
      ),
      response_body: message_sent_response
    )
  end

  def stub_send_hsm_message_with_unknown_contact_response(username, namespace, element_name, params: {})
    stub_default(
      SEND_MESSAGE_URL,
      request_body: send_hsm_message_request(
        username:     username,
        namespace:    namespace,
        element_name: element_name,
        params:       params
      ),
      response_body: message_sent_with_unknown_contact_response
    )
  end

  def stub_default(url, method: :post, request_body:, response_body:, status: 200)
    stub = stub_request(method, url)
      .with(
        body: request_body,
        headers: { "Content-Type" => "application/json" }
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
