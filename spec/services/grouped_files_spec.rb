require 'rails_helper'

describe GroupedFiles do
  subject { GroupedFiles.new input, options }
  let(:input)   { [file_1, file_2, file_3] }
  let(:options) { { by: :test_key } }

  let(:file_1) { double test_key: :test_type_1, to_collapsable_h: hash_1 }
  let(:file_2) { double test_key: :test_type_1, to_collapsable_h: hash_2 }
  let(:file_3) { double test_key: :test_type_2, to_collapsable_h: hash_3 }

  let(:hash_1) { { test_method: 2, other_test_method: 3 } }
  let(:hash_2) { { test_method: 2, other_test_method: 4 } }
  let(:hash_3) { { test_method: 1, other_test_method: 2 } }

  describe "enumerability" do
    it "iterates over the collapsed groups of files" do
      acc = []
      subject.each { |elm| acc << elm }

      expect(acc).to eq [ 
        { test_key: :test_type_1, test_method: 4, other_test_method: 7 },
        { test_key: :test_type_2, test_method: 1, other_test_method: 2 }
      ]
    end
  end
end