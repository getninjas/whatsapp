# frozen_string_literal: true

require "spec_helper"

RSpec.describe Whats::Actions::CheckContacts do
  let(:client) { Whats::Client.new("http://test.local") }

  let(:numbers) { ["+5511944442222"] }

  subject { described_class.new(client, numbers) }

  describe "#call" do
    it "calls client request with correct path and payload" do
      expect(client).to receive(:request).with(
        Whats::Actions::CheckContacts::PATH,
        payload: {
          blocking: "wait",
          users:    numbers
        }
      )

      subject.call
    end
  end
end
