require 'rails_helper'

describe Array do
  subject { [] }

  describe "#normalize" do
    subject { [element_1, element_2, element_3] }
    let(:element_1) { double }
    let(:element_2) { double }
    let(:element_3) { double }

    it 'calls normalize on every inner element' do
      subject.each { |elm| expect(elm).to receive(:normalize) }
      subject.normalize
    end
  end
end