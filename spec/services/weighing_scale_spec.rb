require 'rails_helper'

describe WeighingScale do
  subject { WeighingScale.new files }
  let(:files) { [file_1, file_2] }

  let(:file_1) { double weight: 2, size: 1.5 }
  let(:file_2) { double weight: 3, size: 2 }

  describe "#total_weight" do
    it "returns the summed up weight of all files" do
      expect(subject.total_weight).to eq 5
    end
  end

  describe "#total_size" do
    it "returns the summed up weight of all files" do
      expect(subject.total_size).to eq 3.5
    end
  end

  describe "#additional_gravity" do
    it "returns the difference between total_weight and total_size" do
      expect(subject.additional_gravity).to eq 1.5
    end
  end
end