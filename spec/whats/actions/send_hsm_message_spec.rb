# frozen_string_literal: true

require "spec_helper"

RSpec.describe Whats::Actions::SendHsmMessage do
  include WebmockHelper

  subject(:action) do
    described_class.new(client, wa_id, namespace, element_name, params)
  end

  let(:client) { Whats::Client.new(WebmockHelper::BASE_PATH) }

  let(:wa_id) { "55119000111" }

  let(:namespace) { "whatsapp:hsm:banks:enterprisebank" }

  let(:element_name) { "two_factor" }

  let(:params) { { "default" => "1234" } }

  describe "#call" do
    context "with valid params" do
      before { stub_send_hsm_message(wa_id, namespace, element_name, params: params) }

      it "returns message_in in the payload" do
        expect(action.call).to eq "messages" => { "id" => "ID" }
      end
    end

    xcontext "with unknown contact" do
      let(:wa_id) { "123" }

      before { stub_send_hsm_message_with_unknown_contact_response(wa_id, namespace, element_name, params: params) }

      it "returns payload as nil" do
        expect(action.call["payload"]).to be_nil
      end

      it "returns error unknown contact" do
        expect(action.call["error"]).to eq "errorcode" => 404, "errortext" => "unknown contact"
      end
    end
  end
end
