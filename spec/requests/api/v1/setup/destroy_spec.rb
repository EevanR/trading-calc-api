RSpec.describe 'DELETE /api/v1/setups/:id', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  let(:user2) { create(:user, email: "wronguser@mail.com", nickname: "Userman2") }
  let(:credentials2) { user2.create_new_auth_token }
  let!(:headers2) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials2) }
  let!(:setup) { create(:setup, user_id: user.id)  }
  let!(:setup2) { create(:setup)  }

  describe 'Successfully delete setup' do
    before do
      delete "/api/v1/setups/#{setup.id}",
      headers: headers
    end
    
    it 'returns a 204 response status' do
      expect(response).to have_http_status 204
    end

    it "setup count should equal 1" do
      expect(Setup.count).to eq 1
    end
  end

  describe 'Unsuccessfully delete setup as non authorized user' do
    before do
      delete "/api/v1/setups/#{setup.id}",
      headers: headers2
    end
    
    it 'returns a 401 response status' do
      expect(response).to have_http_status 401
    end

    it "setup count should equal 2" do
      expect(Setup.count).to eq 2
    end
  end
end