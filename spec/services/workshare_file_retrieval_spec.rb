require 'rails_helper'

describe WorkshareFileRetrieval do
  before do 
    allow(Workshare::Client).to receive(:files).and_return(file_response)
    allow(file_response).to receive(:has_error_code?).and_return(credentials_error)
  end
  let(:file_response) { double }
  let(:credentials_error) { true }

  describe "self.files" do
    context "with valid credentials" do 
      let(:file_response) { [file_data_1, file_data_2, file_data_3] }
      let(:file_data_1) { {} }
      let(:file_data_2) { {} }
      let(:file_data_3) { {} }
      let(:credentials_error) { false }
      
      it "returns an array of presented files" do
        file_response.each.with_index do |file, i|
          expect(WorkshareFileRetrieval::File).to receive(:new).with(file).
                                                  and_return("file_#{i+1}".to_sym)
        end

        expect(WorkshareFileRetrieval.files('credentials')).to eq [:file_1, :file_2, :file_3]
      end
    end

    context "with invalid credentials" do
      it "raises an invalid credentials error" do
        expect{WorkshareFileRetrieval.files('credentials') }.
          to raise_error(WorkshareFileRetrieval::InvalidSessionError)
      end
    end
  end
end

describe WorkshareFileRetrieval::File do
  before do
    configuration = {
      types: {
        song: ['mp3'],
        video: ['avi', 'mp4', 'mkv'],
        document: ['odt', 'docx', 'doc', 'pdf'],
        text: ['txt'],
        binaries: ['bin']
      },
      weights: {
        song: '1.2 * size',
        video: '1.4 * size',
        document: '1.1 * size',
        text: '100 + size',
        binary: 'size',
        other: 'size'
      },
      size_normalization: {divide: 1000000}
    }
    WorkshareFileRetrieval::File.config configuration
  end
  subject { WorkshareFileRetrieval::File.new file_data }

  let(:file_data) do
    {
     :id=>11377868,
     :name=>"Gemfile",
     :extension=>"txt",
     :version=>1,
     :size=>1000000,
     :created_at=>"2014-10-05T21:08:40Z",
     :updated_at=>"2014-10-05T21:08:42Z",
     :creator=>{:name=>"Jesus Prieto Colomina", :email=>"chus1818@gmail.com", :uuid=>"3c76047e-e81d-4343-84b4-4064bd7ccdb3"},
     :url=>"https://api.workshare.com/decks/11377868",
     :access_token=>"KU_rdj5I_voc1zQ7",
     :first_page_url=>"https://my.workshare.com/images/icons/medium/unknown.png",
     :folder_id=>914151
    }
  end

  describe "#weight" do
    it "evals the configured expression for the given type of file" do
      expect(subject.weight.to_f).to eq 101.0
    end
  end

  describe "#size" do
    it "returns the normalized size" do
      expect(subject.size.to_f).to eq 1.0
    end
  end

  describe "#type" do
    it "returns the type of the file in accord with its extension" do
      expect(subject.type).to eq :text
    end
  end

  describe "#to_collapsable_h" do
    it "returns a hash of numeric values" do
      expect(subject.to_collapsable_h).to eq(weight: 101.0, size: 1.0, amount: 1)
    end
  end
end