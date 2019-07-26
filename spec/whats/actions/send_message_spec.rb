# typed: false
# frozen_string_literal: true

require "spec_helper"

RSpec.describe Whats::Actions::SendMessage do
  include WebmockHelper

  subject(:action) { described_class.new(client, wa_id, body) }

  let(:client) { Whats::Client.new double(token: "key") }

  let(:wa_id) { "5511944442222" }

  let(:body) { "Message!" }

  before do
    Whats.configure { |c| c.base_path = WebmockHelper::BASE_PATH }
  end

  describe "#call" do
    context "with valid params" do
      before { stub_send_message_with_valid_response(wa_id, body) }

      it "returns message_in in the payload" do
        expect(action.call).to eq "messages" => { "id" => "ID" }
      end
    end

    context "with unknown contact" do
      let(:wa_id) { "123" }

      before { stub_send_message_with_unknown_contact_response(wa_id, body) }

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

      before { stub_send_message_with_empty_wa_id_response(body) }

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

      before { stub_send_message_with_empty_body_response(wa_id) }

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
end
