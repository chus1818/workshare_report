require 'rails_helper'

describe Authentication::Errors do
  subject { Authentication::Errors.new :unperformed_authentication }
  before do
    allow(Authentication::Errors::UnperformedAuthentication).to receive(:to_s).
                                                          and_return("unperformed_authentication")
    allow(Authentication::Errors::WrongCredential).to receive(:to_s).
                                                and_return("wrong_credential")
    allow(Authentication::Errors::UnexpectedError).to receive(:to_s).
                                                and_return("unexpected_error")
  end

  describe "#to_s" do
    context "when no extra error has been added" do
      it "returns the error message" do
        expect(subject.to_s).to eq "unperformed_authentication"
      end
    end

    context "when an extra error has been added" do
      it "returns the error messages" do
        subject.add :wrong_credential
        expect(subject.to_s).to eq "unperformed_authentication wrong_credential"
      end
    end
  end

  describe "#remove" do
    context "when the error is present in the list" do
      it "removes the given error from the list" do
        subject.add :wrong_credential
        subject.add :wrong_credential
        subject.remove :wrong_credential

        expect(subject.list).to_not include Authentication::Errors::WrongCredential
      end
    end

    context "when the error is not present in the list" do
      it "does nothing" do
        expect(subject.list).to eq [Authentication::Errors::UnperformedAuthentication]
      end
    end
  end

  describe "#add" do
    context "when the error is not already present in the list" do
      it "adds the error to the list" do
        subject.add :wrong_credential
        expect(subject.list).to include Authentication::Errors::WrongCredential
      end
    end

    context "when the error is already present in the list" do
      it "does nothing" do
        expect(subject.list).to eq [Authentication::Errors::UnperformedAuthentication]
      end
    end
  end

  describe "#empty?" do
    context "when the list has no errors" do
      it "returns true" do
        subject.remove :unperformed_authentication
        expect(subject.empty?).to be true
      end
    end

    context "when the list has errors" do
      it "returns false" do
        expect(subject.empty?).to be false
      end
    end
  end
end