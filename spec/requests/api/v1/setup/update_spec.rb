RSpec.describe 'PUT /api/v1/setups', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  let!(:setup) { create(:setup, user_id: user.id)  }

  describe 'Successfully edits setup details' do
    before do
      patch "/api/v1/setups/#{setup.id}",
      params: {
          req1: "This requirement has changed"
      },
      headers: headers
    end
    
    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it "returns a updated first requirement" do
      expect(response_json['req1']).to eq "This requirement has changed"
    end
  end
end