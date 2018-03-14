# frozen_string_literal: true

require "spec_helper"

RSpec.describe Whats::Actions::SendHsmMessage do
  let(:client) { Whats::Client.new("http://test.local") }

  let(:username) { "5511944442222" }

  let(:namespace) { "namespace" }

  let(:element_name) { "element_name" }

  let(:params) { { key: "value" } }

  subject do
    described_class.new(client, username, namespace, element_name, params)
  end

  describe "#call" do
    it "calls client request with correct path and payload" do
      expect(client).to receive(:request).with(
        Whats::Actions::SendHsmMessage::PATH,
        payload: {
          to: username,
          hsm: {
            namespace:          namespace,
            element_name:       element_name,
            localizable_params: params
          }
        }
      )

      subject.call
    end
  end
end
