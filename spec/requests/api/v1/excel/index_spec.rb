RSpec.describe 'GET /api/v1/excels', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  let!(:excel) do 
    3.times do
      create(:excel, user_id: user.id)
    end
  end

  describe 'Successfully index excel entries' do
    before do
      get '/api/v1/excels',
      headers: headers
    end
    
    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it "setup count should equal 1" do
      expect(response_json.count).to eq 3
    end
  end

  describe 'unsuccessfully index unauthorized excel entries' do
    before do
      get '/api/v1/excels'
    end
    
    it 'returns a 200 response status' do
      expect(response).to have_http_status 401
    end

    it "setup count should equal 1" do
      expect(response_json["errors"][0]).to eq "You need to sign in or sign up before continuing."
    end
  end
end