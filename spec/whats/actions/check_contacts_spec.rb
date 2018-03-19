# frozen_string_literal: true

require "spec_helper"

RSpec.describe Whats::Actions::CheckContacts do
  include WebmockHelper

  subject(:action) { described_class.new(client, numbers) }

  let(:client) { Whats::Client.new(WebmockHelper::BASE_PATH) }

  let(:numbers) { [number] }

  describe "#call" do
    context "with a valid phone number" do
      let(:number) { "+5511944442222" }

      let(:username) { "5511944442222" }

      let(:payload) do
        {
          "results" => [
            {
              "input_number" => number,
              "wa_exists"    => true,
              "wa_username"  => username
            }
          ],
          "total" => 1
        }
      end

      before { stub_check_contacts_with_valid_number(number, username) }

      it "returns the correct payload" do
        expect(action.call["payload"]).to eq payload
      end

      it "returns error as false" do
        expect(action.call["error"]).to eq false
      end
    end

    context "with more than one valid phone number" do
      let(:numbers) { ["+5511944442222", "+55119000888"] }

      let(:usernames) { ["5511944442222", "55119000888"] }

      let(:payload) do
        {
          "results" => [
            {
              "input_number" => numbers[0],
              "wa_exists"    => true,
              "wa_username"  => usernames[0]
            },
            {
              "input_number" => numbers[1],
              "wa_exists"    => true,
              "wa_username"  => usernames[1]
            }
          ],
          "total" => 2
        }
      end

      before { stub_check_contacts_with_valid_numbers(numbers, usernames) }

      it "returns the correct payload" do
        expect(action.call["payload"]).to eq payload
      end
    end

    context "with an invalid phone number" do
      let(:number) { "+123" }

      let(:payload) do
        {
          "results" => [
            {
              "input_number" => number,
              "wa_exists"    => false,
              "wa_username"  => "invalid"
            }
          ],
          "total" => 1
        }
      end

      before { stub_check_contacts_with_invalid_number(number) }

      it "returns the correct payload" do
        expect(action.call["payload"]).to eq payload
      end

      it "returns error as false" do
        expect(action.call["error"]).to eq false
      end
    end
  end
end
