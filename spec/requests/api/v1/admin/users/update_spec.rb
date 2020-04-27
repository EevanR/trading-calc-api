RSpec.describe 'PUT /api/admin/users', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'Successfully edits risk amount' do
    before do
      put "/api/v1/admin/users/#{user.id}",
      params: {
          risk: 0.02
      },
      headers: headers
    end
    
    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it "returns new risk of 0.02" do
      expect(response_json['risk']).to eq 0.02
    end
  end
end