# frozen_string_literal: true

require "spec_helper"

RSpec.describe Whats::Api do
  subject(:api) { described_class.new }

  let(:base_path) { WebmockHelper::BASE_PATH }

  let(:client) { instance_double Whats::Client }

  before do
    allow(Whats::Client).to receive(:new).and_return client
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
      api.check_contacts(numbers)

      expect(action).to have_received(:call)
    end
  end

  describe "#check_contact" do
    let(:number) { "+5511942424242" }

    before do
      allow(Whats::Actions::CheckContacts)
        .to receive(:new)
        .with(client, [number])
        .and_return action
    end

    context "when whatsapp fails" do
      let(:action) do
        instance_double Whats::Actions::CheckContacts, call: failed_response
      end

      let(:failed_response) do
        {
          "errors" => [{
            "code" => 100,
            "title" => "Generic error",
            "details" => "Genereic error description"
          }]
        }
      end

      it "raises a request error" do
        expect { api.check_contact(number) }.to raise_error Whats::Errors::RequestError
      end
    end

    context "when whatsapp succeed" do
      let(:action) do
        instance_double Whats::Actions::CheckContacts, call: response
      end

      let(:response) do
        {
          "contacts" => [
            {
              "input" => "+5511942424242",
              "status" => "valid",
              "wa_id" => "5511942424242"
            }
          ]
        }
      end

      it "formats the response for a single number" do
        result = api.check_contact(number)

        expect(result).to eq(
          "input" => "+5511942424242",
          "status" => "valid",
          "wa_id" => "5511942424242"
        )
      end
    end
  end

  describe "#send_message" do
    let(:action) { instance_double("Whats::Actions::SendMessage", call: "action result") }

    let(:wa_id) { "5511942424242" }
    let(:phone_id) { "9999999999999" }
    let(:type) { "text" }
    let(:body) { "Message" }

    before do
      allow(Whats::Actions::SendMessage)
        .to receive(:new)
        .with(client, wa_id, phone_id, type, body)
        .and_return action
    end

    it "calls the specific action" do
      expect(api.send_message(wa_id, type, body)).to eq "action result"
    end
  end
end
