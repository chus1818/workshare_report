require 'rails_helper'

describe Object do
  subject { Object.new }

  describe '#normalize' do
    it 'returns itself' do
      expect(subject.normalize).to eq subject
    end
  end
end