# frozen_string_literal: true

require "spec_helper"

RSpec.describe Whats::Client do
  subject { described_class.new(base_path) }

  let(:base_path) { "http://whats.test" }

  describe "#request" do
    let(:path) { "/path" }

    let(:full_path) { "#{base_path}#{path}" }

    let(:payload) { { param: 123 } }

    let(:payload_json) { { param: 123 }.to_json }

    let(:response) { { key: "value" }.to_json }

    context "in a happy path" do
      before do
        stub_request(:post, full_path)
          .with(
            body: payload_json,
            headers: { "Content-Type" => "application/json" }
          )
          .to_return(status: 200, body: response)
      end

      it "executes a POST request properly" do
        subject.request("/path", payload)

        expect(WebMock)
          .to have_requested(:post, full_path)
          .with(
            body: payload_json,
            headers: { "Content-Type" => "application/json" }
          )
      end

      it "returns the response represented in hash" do
        result = subject.request("/path", payload)

        expect(result).to eq("key" => "value")
      end
    end

    context "with a server error" do
      before do
        stub_request(:post, full_path)
          .with(
            body: payload_json,
            headers: { "Content-Type" => "application/json" }
          )
          .to_return(status: 500, body: "")
      end

      it "raises a specific error" do
        expect { subject.request("/path", payload) }.to raise_error do |error|
          expect(error.class).to eq Whats::Errors::RequestError
          expect(error.response.class).to eq Typhoeus::Response
        end
      end
    end
  end
end
