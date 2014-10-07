require 'rails_helper'

describe Workshare::Client do
  subject { Workshare::Client }

  describe "self.login" do
    let(:user_credentials) { :some }
    let(:options) do
      { body: { user_session: user_credentials, device: { app_uid: 'test_key' } } }
    end
    
    it "returns a presented response" do
      stub_workshare_client_request :post, '/api/open-v1.0/user_sessions.json', options
      expect(Workshare::Client::Presenters::LoginResponse).to receive(:new).with(:response)
      
      subject.login user_credentials
    end
  end

  describe "self.files" do
    let(:access_credentials) { "device_credentials=sZoSp3opgGc7W-9QwHdJAw; domain=.workshare.com; path=/; secure, my_session_id=aba061079235f54193759dcd5b534c82; domain=.workshare.com; path=/; secure; HttpOnly" }
    let(:expected_cookies) { {:device_credentials=>"sZoSp3opgGc7W-9QwHdJAw", :domain=>".workshare.com", :path=>"/", :secure=>nil, :" my_session_id"=>"aba061079235f54193759dcd5b534c82", :HttpOnly=>nil} }
    let(:options) { { cookies: expected_cookies } }

    it "returns a presented response" do
      stub_workshare_client_request :get, '/api/open-v1.0/files.json', options
      expect(Workshare::Client::Presenters::Files).to receive(:new).with(:response)
      
      subject.files access_credentials
    end
  end
end