require 'rails_helper'

describe WorkshareFileReport do
  subject { WorkshareFileReport.new files, grouper: grouper, weighter: weighter }
  let(:files) { double }
  let(:grouper) { double }
  let(:weighter) { double }

  before { allow(weighter).to receive(:new).and_return weighting_scale }
  let(:weighting_scale) { double }

  describe "#groups" do
    it "returns the files grouped by type" do
      expect(grouper).to receive(:new).with(files, by: :type)
      subject.groups
    end
  end

  describe "#total_weight" do
    it "returns the total weight of the files" do
      expect(weighting_scale).to receive(:total_weight)
      subject.total_weight
    end
  end

  describe "#additional_gravity" do
    it "returns the total additional_gravity of the files" do
      expect(weighting_scale).to receive(:additional_gravity)
      subject.additional_gravity
    end
  end
end