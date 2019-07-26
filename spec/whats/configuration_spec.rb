# typed: false
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

  context "when user is configured" do
    let(:user) { "user" }

    before do
      Whats.configure { |config| config.user = user }
    end

    it "is expeted that the user is configure" do
      expect(Whats.configuration.user).to be user
    end
  end

  context "when password is configured" do
    let(:password) { "password" }

    before do
      Whats.configure { |config| config.password = password }
    end

    it "is expeted that the password is configure" do
      expect(Whats.configuration.password).to be password
    end
  end
end
