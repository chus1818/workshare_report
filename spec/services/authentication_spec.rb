require 'rails_helper'

describe Authentication do
  subject { Authentication.new credentials, engine }
  let(:credentials) { {} }
  let(:engine) { double }

  before { allow(engine).to receive(:login).with(credentials).and_return(login_response) }
  let(:login_response) { double has_error_code?: login_error, access_cookies: expected_access_cookies }
  let(:login_error) { false }
  let(:expected_access_cookies) { double }

  describe '#perform' do
    it "removes the unperformed_authentication error" do
      subject.perform
      expect(subject.errors.list).to_not include Authentication::Errors::UnperformedAuthentication
    end

    it "call login on the login engine" do
      expect(engine).to receive(:login).with(credentials).and_return(login_response)
      subject.perform
    end

    it "returns self" do
      expect(subject.perform).to eq subject
    end

    context "when the login has an error code" do
      let(:login_error) { true }

      it "adds a wrong credentials error" do
        subject.perform
        expect(subject.errors.list).to include Authentication::Errors::WrongCredential
      end
    end

    context "when the login has not an error code" do
      it "does not add a wrong credentials error" do
        subject.perform
        expect(subject.errors.list).to_not include Authentication::Errors::WrongCredential
      end
    end
  end

  describe '#success?' do
    context "before performing a request" do
      it "return false" do
        expect(subject.success?).to be false
      end
    end

    context "after successfully performing a request" do
      it "returns true" do
        subject.perform
        expect(subject.success?).to be true
      end
    end

    context "after unsuccessfully performing a request" do
      let(:login_error) { true }

      it "returns false" do
        subject.perform
        expect(subject.success?).to be false
      end
    end
  end

  describe "#access_cookies" do
    context "when the login is a success" do
      it "returns the access cookies" do
        subject.perform
        expect(subject.access_cookies).to eq expected_access_cookies
      end
    end

    context "when the login is not a success" do
      it "returns nil" do
        expect(subject.access_cookies).to be_nil
      end
    end
  end
end