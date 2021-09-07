RSpec.describe 'GET /api/v1/admin/users/:id', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'show user attributes if still logged in' do
    before do
      get "/api/v1/admin/users/#{user.id}",
      headers: headers
    end
    
    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it "returns new risk of 0.02" do
      expect(response_json['id']).to eq user.id
    end
  end
end