# frozen_string_literal: true

require "spec_helper"

RSpec.describe Whats::Actions::SendHsmMessage do
  include WebmockHelper

  subject(:action) do
    described_class.new(client, username, namespace, element_name, params)
  end

  let(:client) { Whats::Client.new(WebmockHelper::BASE_PATH) }

  let(:username) { "55119000111" }

  let(:namespace) { "whatsapp:hsm:banks:enterprisebank" }

  let(:element_name) { "two_factor" }

  let(:params) { { "default" => "1234" } }

  describe "#call" do
    context "with valid params" do
      before { stub_send_hsm_message(username, namespace, element_name, params: params) }

      it "returns message_in in the payload" do
        expect(action.call["payload"]).to eq "message_id" => "ID"
      end

      it "returns error as false" do
        expect(action.call["error"]).to eq false
      end
    end

    context "with unknown contact" do
      let(:username) { "123" }

      before { stub_send_hsm_message_with_unknown_contact_response(username, namespace, element_name, params: params) }

      it "returns payload as nil" do
        expect(action.call["payload"]).to be_nil
      end

      it "returns error unknown contact" do
        expect(action.call["error"]).to eq "errorcode" => 404, "errortext" => "unknown contact"
      end
    end
  end
end
