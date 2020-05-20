# frozen_string_literal: true

RSpec.describe 'POST /api/v1/trades', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'Succesfully creates setup' do
    before do
      
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end
  end

end