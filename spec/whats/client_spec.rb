# typed: false
# frozen_string_literal: true

require "spec_helper"

RSpec.describe Whats::Client do
  subject(:client) { described_class.new double(token: "key") }

  let(:base_path) { WebmockHelper::BASE_PATH }

  describe "#request" do
    let(:path) { "/path" }

    let(:full_path) { "#{base_path}#{path}" }

    let(:payload) { { param: 123 } }

    let(:payload_json) { { param: 123 }.to_json }

    let(:response) { { key: "value" }.to_json }

    context "with valid params" do
      before do
        Whats.configure { |c| c.base_path = base_path }
        stub_request(:post, full_path)
          .with(
            body: payload_json,
            headers: { "Content-Type" => "application/json" }
          )
          .to_return(status: 200, body: response)
      end

      it "executes a POST request properly" do
        client.request("/path", payload)

        expect(WebMock)
          .to have_requested(:post, full_path)
          .with(
            body: payload_json,
            headers: { "Content-Type" => "application/json" }
          )
      end

      it "returns the response represented in hash" do
        result = client.request("/path", payload)

        expect(result).to eq("key" => "value")
      end
    end

    context "with a server error" do
      before do
        Whats.configure { |c| c.base_path = base_path }
        stub_request(:post, full_path)
          .with(
            body: payload_json,
            headers: { "Content-Type" => "application/json" }
          )
          .to_return(status: 500, body: "")
      end

      it "raises a specific error" do
        expect { client.request("/path", payload) }.to raise_error Whats::Errors::RequestError
      end

      it "raises an error with response property" do
        begin
          client.request("/path", payload)
        rescue Whats::Errors::RequestError => error
          expect(error.response.class).to eq Typhoeus::Response
        end
      end
    end
  end
end
