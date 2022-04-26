RSpec.describe 'GET /api/v1/admin/excels', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  let!(:excel) { create(:excel, user_id: user.id) }

  describe 'Successfully index excel entries' do
    before do
      get '/api/v1/admin/excels',
      headers: headers
    end
    
    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it "setup count should equal 1" do
      binding.pry

      expect(response_json.count).to eq 1
    end
  end

  describe 'unsuccessfully index unauthorized excel entries' do
    before do
      get '/api/v1/admin/excels'
    end
    
    it 'returns a 401 response status' do
      expect(response).to have_http_status 401
    end

    it "returns not sign in error message" do
      expect(response_json["errors"][0]).to eq "You need to sign in or sign up before continuing."
    end
  end

  describe 'Show full entry when subscriber' do
    before do
      get "/api/v1/admin/excels",
      headers: headers
    end

    it 'returns full Excel data set' do
      expect(response_json[0]["data"].count).to eq 12
    end
  end

  describe 'Show error message when not subscriber' do
    let(:user2) { create(:user, email: "user2@mail.com", nickname: "Userman2", role: "user") }
    let(:credentials2) { user2.create_new_auth_token }
    let!(:headers2) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials2) }
    let(:excel2) { create(:excel, user_id:user2.id ) }
    before do
      get "/api/v1/admin/excels",
      headers: headers2
    end

    it 'returns a 403 response status' do
      expect(response).to have_http_status 403
    end

    it 'returns not authorized error' do
      expect(response_json["errors"]).to eq "Not Authorized"
    end
  end
end