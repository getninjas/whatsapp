# frozen_string_literal: true

require "spec_helper"

RSpec.describe Whats::Actions::Login do
  include WebmockHelper

  before do
    Whats.configure do |config|
      config.base_path = WebmockHelper::BASE_PATH
      config.phone_id = "9999999999999"
      config.token = "toooo.kkkkk.eeeen"
    end
  end

  describe "#token" do
    let(:token) { "toooo.kkkkk.eeeen" }

    before { stub_login(token) }

    it "returns a valid token" do
      client = instance_double(Whats::Client)
      allow(client).to receive(:request).with("/v1/users/login").and_return({ "users" => [{ "token" => token }] })

      login_instance = described_class.new(client)
      extracted_token = login_instance.token

      expect(extracted_token).to eq(token)
    end
  end
end
