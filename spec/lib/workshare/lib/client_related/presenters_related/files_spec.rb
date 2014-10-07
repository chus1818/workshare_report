require 'rails_helper'

describe Workshare::Client::Presenters::Files do
  subject { Workshare::Client::Presenters::Files.new raw }
  let(:raw) { { 'pagination' => {}, 'files' => files_data } }
  let(:files_data) { {'aKey' => 'some', 'anotherKey' => 'some' } }

  describe "#elements" do
    it "returns the list of files extracted from the input raw" do
      expect(subject.elements).to eq a_key: 'some', another_key: 'some'
    end
  end
end