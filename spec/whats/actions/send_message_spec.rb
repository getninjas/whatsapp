# frozen_string_literal: true

require "spec_helper"

RSpec.describe Whats::Actions::SendMessage do
  let(:client) { Whats::Client.new("http://test.local") }

  let(:username) { "5511944442222" }

  let(:body) { "Message!" }

  subject { described_class.new(client, username, body) }

  describe "#call" do
    it "calls client request with correct path and payload" do
      expect(client).to receive(:request).with(
        "/api/rest_send.php",
        payload: {
          to:   username,
          body: body
        }
      )

      subject.call
    end
  end
end
