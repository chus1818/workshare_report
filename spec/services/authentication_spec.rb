require 'rails_helper'

describe Authentication do
  subject { Authentication.new credentials, engine }
  let(:credentials) { {} }
  let(:engine) { double }

  before { allow(engine).to receive(:login).with(credentials).and_return(login_response) }
  let(:login_response) { double has_error_code?: login_error }
  let(:login_error) { false }

  describe '#perform' do
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

    context "after a login fail (i.e. timeout)" do
      let(:login_error) { raise StandardError }

      it "returns false" do
        subject.perform
        expect(subject.success?).to be false
      end
    end
  end
end