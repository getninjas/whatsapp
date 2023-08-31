# frozen_string_literal: true

require "spec_helper"

RSpec.describe Whats::Actions::MarkRead do
  include WebmockHelper

  before do
    Whats.configure do |config|
      config.base_path = WebmockHelper::BASE_PATH
      config.phone_id = "9999999999999"
      config.token = "toooo.kkkkk.eeeen"
    end
  end

  subject(:action) { described_class.new(client, message_id, phone_id) }

  let(:client) { Whats::Client.new double(token: "key") }
  let(:message_id) { "123" }
  let(:phone_id) { "9999999999999" }

  describe "#call" do
    context "with valid params" do
      before { stub_mark_read_with_valid_params(message_id, phone_id) }

      it "returns success in the payload" do
        expect(action.call).to eq "success" => true
      end
    end

    context "with invalid params" do
      let(:message_id) { "" }

      before { stub_mark_read_with_invalid_params(message_id) }

      it "returns a OAuthException error" do
        expect(action.call).to eq "error" => { "type" => "OAuthException" }
      end
    end
  end
end
