# frozen_string_literal: true

require "spec_helper"

RSpec.describe Whats::Actions::SendMessage do
  include WebmockHelper
  
  before do
    Whats.configure do |config|
      config.base_path = WebmockHelper::BASE_PATH
      config.phone_id = "9999999999999"
      config.token = "toooo.kkkkk.eeeen"
    end
  end

  subject(:action) { described_class.new(client, wa_id, phone_id, type, body) }

  let(:client) { Whats::Client.new double(token: "key") }
  let(:wa_id) { "5511944442222" }
  let(:phone_id) { Whats.configuration.phone_id }
  let(:type) { "text" }
  let(:body) { "Message!" }

  describe "#call" do
    context "with valid params" do
      before { stub_send_message_with_valid_response(phone_id, wa_id, body) }

      it "returns message_in in the payload" do
        expect(action.call).to eq "messages" => { "id" => "ID" }
      end
    end

    context "with unknown contact" do
      let(:wa_id) { "123" }

      before { stub_send_message_with_unknown_contact_response(phone_id, wa_id, body) }

      it "returns payload as nil" do
        expect(action.call["messages"]).to be_nil
      end

      it "returns error unknown contact" do
        expect(action.call["errors"]).to eq [{
          "code" => 1006,
          "title" => "Resource not found",
          "details" => "unknown contact"
        }]
      end
    end

    context "with an empty wa_id" do
      let(:wa_id) { "" }

      before { stub_send_message_with_empty_wa_id_response(phone_id, body) }

      it "returns payload as nil" do
        expect(action.call["messages"]).to be_nil
      end

      it "returns error of missing payload|to" do
        expect(action.call["error"]).to eq(
          "errorcode" => 400,
          "errortext" => "missing params payload|to"
        )
      end
    end

    context "with an empty body" do
      let(:body) { "" }

      before { stub_send_message_with_empty_body_response(phone_id, wa_id) }

      it "returns payload as nil" do
        expect(action.call["messages"]).to be_nil
      end

      it "returns error of missing message" do
        expect(action.call["error"]).to eq(
          "errorcode" => 400,
          "errortext" => "missing required message body definition"
        )
      end
    end
  end

  describe "#payload" do
    context "with type 'text'" do
      it "returns a payload with the correct structure for text messages" do
        expected_payload = {
          messaging_product: "whatsapp",
          recipient_type: "individual",
          to: wa_id,
          type: type,
          text: {
            body: body
          }
        }

        expect(action.send(:payload)).to eq(expected_payload)
      end
    end

    context "with type 'interactive'" do
      let(:type) { "interactive" }
      let(:body) { { your: "interactive_body" } }

      it "returns a payload with the correct structure for interactive messages" do
        expected_payload = {
          messaging_product: "whatsapp",
          recipient_type: "individual",
          to: wa_id,
          type: type,
          interactive: body
        }

        expect(action.send(:payload)).to eq(expected_payload)
      end
    end

    context "with an unknown type" do
      let(:type) { "invalid_type" }

      it "raises a RequestError with an appropriate error message" do
        expect { action.send(:payload) }.to raise_error do |error|
          expect(error).to be_a(Whats::Errors::RequestError)
          expect(error.message).to eq("WhatsApp error: type should be 'text' or 'interactive'")
          expect(error.response).to be_nil
        end
      end
    end
  end
end
