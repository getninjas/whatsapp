# frozen_string_literal: true

require "spec_helper"

RSpec.describe Whats::Api do
  subject(:api) { described_class.new(base_path) }

  let(:base_path) { WebmockHelper::BASE_PATH }

  let(:client) { instance_double Whats::Client }

  before do
    allow(Whats::Client).to receive(:new).with(base_path).and_return client
  end

  describe "#check_contacts" do
    let(:action) { instance_double Whats::Actions::CheckContacts, call: nil }
    let(:numbers) { ["+5511942424242"] }

    before do
      allow(Whats::Actions::CheckContacts)
        .to receive(:new)
        .with(client, numbers)
        .and_return action
    end

    it "calls the specific action" do
      expect(api.check_contacts(numbers)).to eq "action result"
    end
  end

  describe "#check_contact" do
    let(:action) { instance_double("Whats::Actions::CheckContacts", call: response) }

    let(:number) { "+5511942424242" }

    let(:response) do
      {
        "meta" => {
          "waent version" => "2.18.4"
        },
        "payload" => {
          "results" => [
            {
              "input_number" => "+5511942424242",
              "wa_exists" => true,
              "wa_username" => "5511942424242"
            }
          ],
          "total" => 1
        },
        "error" => false
      }
    end

    before do
      allow(Whats::Actions::CheckContacts)
        .to receive(:new)
        .with(client, [number])
        .and_return action
    end

    it "formats the response for a single number" do
      result = api.check_contact(number)

      expect(result).to eq(
        "input_number" => "+5511942424242",
        "wa_exists" => true,
        "wa_username" => "5511942424242"
      )
    end
  end

  describe "#send_message" do
    let(:action) { instance_double("Whats::Actions::SendMessage", call: "action result") }

    let(:username) { "5511942424242" }

    let(:body) { "Message" }

    before do
      allow(Whats::Actions::SendMessage)
        .to receive(:new)
        .with(client, username, body)
        .and_return action
    end

    it "calls the specific action" do
      expect(api.send_message(username, body)).to eq "action result"
    end
  end

  describe "#send_hsm_message" do
    let(:action) { instance_double("Whats::Actions::SendHsmMessage", call: "action result") }

    let(:username) { "5511942424242" }

    let(:namespace) { "namespace" }

    let(:element_name) { "element_name" }

    let(:params) { { key: "value" } }

    before do
      allow(Whats::Actions::SendHsmMessage)
        .to receive(:new)
        .with(client, username, namespace, element_name, params)
        .and_return action
    end

    it "calls the specific action" do
      expect(api.send_hsm_message(username, namespace, element_name, params)).to eq "action result"
    end
  end
end
