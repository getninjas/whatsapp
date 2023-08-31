# frozen_string_literal: true

require "spec_helper"

RSpec.describe Whats, ".configuration" do
  subject(:configuration) { Whats.configuration }

  context "when no configuration is done" do
    before "clean whats module" do
      Whats.configuration = nil
    end
    it { is_expected.to be_nil }
  end

  context "when base path is configured" do
    let(:base_path) { "base_path" }

    before do
      Whats.configure { |config| config.base_path = base_path }
    end

    it "is expeted that the base_path is configure" do
      expect(Whats.configuration.base_path).to be base_path
    end
  end

  context "when phone_id is configured" do
    let(:phone_id) { "phone_id" }

    before do
      Whats.configure { |config| config.phone_id = phone_id }
    end

    it "is expeted that the phone_id is configure" do
      expect(Whats.configuration.phone_id).to be phone_id
    end
  end

  context "when token is configured" do
    let(:token) { "token" }

    before do
      Whats.configure { |config| config.token = token }
    end

    it "is expeted that the token is configure" do
      expect(Whats.configuration.token).to be token
    end
  end
end
