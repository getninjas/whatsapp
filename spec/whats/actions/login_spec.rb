# frozen_string_literal: true

require "spec_helper"
require "base64"

RSpec.describe Whats::Actions::Login do
  include WebmockHelper

  before do
    Whats.configure do |config|
      config.base_path = WebmockHelper::BASE_PATH
      config.user = "username"
      config.password = "secret_password"
    end
  end

  describe "#token" do
    subject { described_class.new.token }

    let(:token) { "toooo.kkkkk.eeeen" }
    let(:credential) { Base64.encode64("username:secret_password").chomp }

    before { stub_login token, credential }

    it "returns a valid token" do
      is_expected.to eq token
    end
  end
end
