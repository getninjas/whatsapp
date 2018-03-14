# frozen_string_literal: true

require "spec_helper"

RSpec.describe Whats::Api do
  let(:base_path) { "http://whats.test" }

  subject { described_class.new(base_path) }

  let(:client) { double request: nil }

  let(:action) { double call: nil }

  before do
    allow(Whats::Client).to receive(:new).with(base_path).and_return client
  end

  describe "#check_contacts" do
    let(:numbers) { ["+5511942424242"] }

    it "calls the specific action" do
      allow(Whats::Actions::CheckContacts)
        .to receive(:new)
        .with(client, numbers)
        .and_return action

      expect(action).to receive :call

      subject.check_contacts(numbers)
    end
  end

  describe "#send_message" do
    let(:username) { "5511942424242" }

    let(:body) { "Message" }

    it "calls the specific action" do
      allow(Whats::Actions::SendMessage)
        .to receive(:new)
        .with(client, username, body)
        .and_return action

      expect(action).to receive :call

      subject.send_message(username, body)
    end
  end

  describe "#send_hsm_message" do
    let(:username) { "5511942424242" }

    let(:namespace) { "namespace" }

    let(:element_name) { "element_name" }

    let(:params) { { key: "value" } }

    it "calls the specific action" do
      allow(Whats::Actions::SendHsmMessage)
        .to receive(:new)
        .with(client, username, namespace, element_name, params)
        .and_return action

      expect(action).to receive :call

      subject.send_hsm_message(username, namespace, element_name, params)
    end
  end
end
