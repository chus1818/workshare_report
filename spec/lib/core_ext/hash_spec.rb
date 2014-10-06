require 'rails_helper'

describe Hash do
  subject { {} }

  describe "#normalize" do
    context "one level hash" do
      subject do 
        { 'aKey' => :some, another_key: :some, anotherKey: :some, 'another_key' => :some }
      end

      let(:expected_normalization) do
        { a_key: :some, another_key: :some, another_key: :some, another_key: :some }
      end

      it 'returns a hash with all its keys symbolized and underscored' do
        expect(subject.normalize).to eq expected_normalization
      end
    end

    context "multiple level hash" do
      subject do 
        { 'aKey' => :some, another_key: { anotherKey: :some } }
      end

      let(:expected_normalization) do
        { a_key: :some, another_key: { another_key: :some } }
      end

      it 'returns a hash with all its keys symbolized and underscored' do
        expect(subject.normalize).to eq expected_normalization
      end
    end

    context "multiple + 1 level hash" do
      subject do 
        { 'aKey' => :some, another_key: { anotherKey: :some, 'another_key' => { anotherKey: :some } } }
      end

      let(:expected_normalization) do
        { a_key: :some, another_key: { another_key: :some, another_key: { another_key: :some } } }
      end

      it 'returns a hash with all its keys symbolized and underscored' do
        expect(subject.normalize).to eq expected_normalization
      end
    end
  end
end