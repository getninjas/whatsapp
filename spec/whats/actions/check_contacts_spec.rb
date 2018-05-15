# frozen_string_literal: true

require "spec_helper"

RSpec.describe Whats::Actions::CheckContacts do
  include WebmockHelper

  subject(:action) { described_class.new client, contacts }

  let(:client) { Whats::Client.new }
  let(:contacts) { [contact] }

  before do
    Whats.configure { |c| c.base_path = WebmockHelper::BASE_PATH }
  end

  describe "#call" do
    context "with a valid phone number" do
      let(:contact) { "+5511944442222" }

      let(:wa_id) { "5511944442222" }

      let(:payload) do
        {
          "contacts" => [
            {
              "input"  => contact,
              "status" => "valid",
              "wa_id"  => wa_id
            }
          ]
        }
      end

      before { stub_check_contacts_with_valid_number(contact, wa_id) }

      it "returns the correct payload" do
        expect(action.call).to eq payload
      end
    end

    context "with more than one valid phone number" do
      let(:contacts) { ["+5511944442222", "+55119000888"] }

      let(:wa_ids) { ["5511944442222", "55119000888"] }

      let(:payload) do
        {
          "contacts" => [
            {
              "input"  => contacts[0],
              "status" => "valid",
              "wa_id"  => wa_ids[0]
            },
            {
              "input"  => contacts[1],
              "status" => "valid",
              "wa_id"  => wa_ids[1]
            }
          ]
        }
      end

      before { stub_check_contacts_with_valid_numbers(contacts, wa_ids) }

      it "returns the correct payload" do
        expect(action.call).to eq payload
      end
    end

    context "with an invalid phone number" do
      let(:contact) { "+123" }

      let(:payload) do
        {
          "contacts" => [
            {
              "input"  => contact,
              "status" => "invalid",
            }
          ]
        }
      end

      before { stub_check_contacts_with_invalid_number(contact) }

      it "returns the correct payload" do
        expect(action.call).to eq payload
      end
    end
  end
end
