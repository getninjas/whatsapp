# frozen_string_literal: true

require "spec_helper"

RSpec.describe Whats::Actions::SendHsmMessage do
  include WebmockHelper

  subject(:action) do
    described_class.new(client, wa_id, namespace, element_name, language, params, button_params)
  end

  let(:client) { Whats::Client.new double(token: "key") }

  let(:wa_id) { "55119000111" }

  let(:namespace) { "whatsapp:hsm:banks:enterprisebank" }

  let(:element_name) { "two_factor" }

  let(:language) { "en" }

  let(:params) { [{ "type" => "text", "text" => "1234" }] }

  let(:button_params) { [{ "type" => "text", "text" => "1234" }] }

  before do
    Whats.configure { |c| c.base_path = WebmockHelper::BASE_PATH }
  end

  describe "#call" do
    context "with valid params" do
      before { stub_send_hsm_message(wa_id, namespace, element_name, language, params: params) }

      it "returns message_in in the payload" do
        expect(action.call).to eq "messages" => { "id" => "ID" }
      end
    end

    context "with unknown contact" do
      let(:wa_id) { "123" }

      before { stub_send_hsm_message_with_unknown_contact_response(wa_id, namespace, element_name, language, params: params) }

      it "returns payload as nil" do
        expect(action.call["payload"]).to be_nil
      end

      it "returns error unknown contact" do
        expect(action.call["errors"]).to eq [{
          "code" => 1006,
          "details" => "unknown contact",
          "title" => "Resource not found"
          }]
      end
    end
  end
end
