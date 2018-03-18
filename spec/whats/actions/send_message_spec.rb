# frozen_string_literal: true

require "spec_helper"

RSpec.describe Whats::Actions::SendMessage do
  include WebmockHelper

  subject(:action) { described_class.new(client, username, body) }

  let(:client) { Whats::Client.new(WebmockHelper::BASE_PATH) }

  let(:username) { "5511944442222" }

  let(:body) { "Message!" }

  describe "#call" do
    context "with valid params" do
      before { stub_send_message_with_valid_response(username, body) }

      it "returns message_in in the payload" do
        expect(action.call["payload"]).to eq "message_id" => "ID"
      end

      it "returns error as false" do
        expect(action.call["error"]).to eq false
      end
    end

    context "with unknown contact" do
      let(:username) { "123" }

      before { stub_send_message_with_unknown_contact_response(username, body) }

      it "returns payload as nil" do
        expect(action.call["payload"]).to be_nil
      end

      it "returns error unknown contact" do
        expect(action.call["error"]).to eq(
          "errorcode" => 404,
          "errortext" => "unknown contact"
        )
      end
    end

    context "with an empty username" do
      let(:username) { "" }

      before { stub_send_message_with_empty_username_response(body) }

      it "returns payload as nil" do
        expect(action.call["payload"]).to be_nil
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

      before { stub_send_message_with_empty_body_response(username) }

      it "returns payload as nil" do
        expect(action.call["payload"]).to be_nil
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
