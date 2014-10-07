require 'rails_helper'

describe ReportsController do
  describe "GET show" do
    before do
      stub_workshare_client_request(:get, '/api/open-v1.0/files.json', options) { files_data }
      get :show, {}, {credentials:  "device_credentials=sZoSp3opgGc7W-9QwHdJAw; domain=.workshare.com; path=/; secure, my_session_id=aba061079235f54193759dcd5b534c82; domain=.workshare.com; path=/; secure; HttpOnly"}
    end

    let(:files_data) do
      {
        "pagination"=>{"current_page"=>1, "total_pages"=>1, "total_entries"=>16},
        "files"=> [
          {"id"=>11377868,
          "name"=>"Gemfile",
          "extension"=>"",
          "version"=>1,
          "size"=>1,
          "created_at"=>"2014-10-05T21:08:40Z",
          "updated_at"=>"2014-10-05T21:08:42Z",
          "creator"=>{"name"=>"Jesus Prieto Colomina", "email"=>"chus1818@gmail.com", "uuid"=>"3c76047e-e81d-4343-84b4-4064bd7ccdb3"},
          "url"=>"https://api.workshare.com/decks/11377868",
          "access_token"=>"KU_rdj5I_voc1zQ7",
          "first_page_url"=>"https://my.workshare.com/images/icons/medium/unknown.png",
          "folder_id"=>914151},
         {"id"=>11377866,
          "name"=>"GOPR4611",
          "extension"=>"mp4",
          "version"=>1,
          "size"=>2,
          "created_at"=>"2014-10-05T21:07:33Z",
          "updated_at"=>"2014-10-05T21:08:16Z",
          "creator"=>{"name"=>"Jesus Prieto Colomina", "email"=>"chus1818@gmail.com", "uuid"=>"3c76047e-e81d-4343-84b4-4064bd7ccdb3"},
          "url"=>"https://api.workshare.com/decks/11377866",
          "access_token"=>"dvU3GYPOKpE0s7KP",
          "first_page_url"=>"https://my.workshare.com/images/icons/medium/unknown.png",
          "folder_id"=>914151}
        ]
      }
    end

    let(:options) do
      { 
        cookies: {
          :device_credentials=>"sZoSp3opgGc7W-9QwHdJAw",
          :domain=>".workshare.com",
          :path=>"/",
          :secure=>nil,
          :" my_session_id"=>"aba061079235f54193759dcd5b534c82",
          :HttpOnly=>nil
        } 
      }
    end

    it "sets a report" do
      expect(assigns(:report)).to be_kind_of(WorkshareFileReport)
      expect(assigns(:report).files.count).to eq 2
    end

    it "renders the template" do
      expect(response.status).to eq(200)
      expect(response).to render_template(:show)
    end
  end
end