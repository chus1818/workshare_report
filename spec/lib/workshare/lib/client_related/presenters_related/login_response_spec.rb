require 'rails_helper'

describe Workshare::Client::Presenters::LoginResponse do
  subject { Workshare::Client::Presenters::LoginResponse.new response }

  let(:response) { double headers: headers, to_h: body }
  let(:headers) { { "set-cookie"=> :cookies } }
  let(:body) { { "device_auth_token"=>"VdrV6tNe-4Fsmbp2SHbw_A" } }

  describe "#access_cookies" do
    context "when there is a set-cookie header" do
      it "returns the set-cookie header" do
        expect(subject.access_cookies).to eq :cookies
      end
    end

    context "when there is not a set-cookie header" do
      let(:headers) { {} }

      it "returns nil" do
        expect(subject.access_cookies).to be_nil
      end
    end
  end

  describe "#has_error_code?" do
    context "when there is an error code in the body of the response" do
      let(:body) { { 'error_code' => "some value" } }

      it "returns true" do
        expect(subject.has_error_code?).to be true
      end
    end

    context "when there is not error code in the body of the response" do
      it "returns false" do
        expect(subject.has_error_code?).to be false
      end
    end
  end
end