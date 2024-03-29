# spec/requests/api/v1/registrations_spec.rb

RSpec.describe 'POST /api/v1/auth', type: :request do
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  describe 'with valid credentials' do
    before do
      post '/api/v1/auth',
          params: {
            email: 'example@craftacademy.se',
            password: 'password',
            password_confirmation: 'password',
            nickname: 'CraftMan'
          },
          headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns a success message' do
      expect(response_json['status']).to eq 'success'
    end

    it "returns default role as 'user'" do
      expect(response_json['data']['role']).to eq 'user'
    end
  end

  context 'when a user submits' do
    describe 'a non-matching password confirmation' do
      before do
        post '/api/v1/auth',
            params: {
              email: 'example@craftacademy.se',
              password: 'password',
              password_confirmation: 'wrong_password'
            },
            headers: headers
      end

      it 'returns a 422 response status' do
        expect(response).to have_http_status 422
      end

      it 'returns an error message' do
        expect(response_json['errors']['password_confirmation']).to eq ["doesn't match Password"]
      end
    end

    describe 'an invalid email address' do
      before do
        post '/api/v1/auth',
            params: {
              email: 'example@craft',
              password: 'password',
              password_confirmation: 'password'
            },
            headers: headers
      end

      it 'returns a 422 response status' do
        expect(response).to have_http_status 422
      end

      it 'returns an error message' do
        expect(response_json['errors']['email']).to eq ['is not an email']
      end
    end

    describe 'an already registered email' do
      let!(:registered_user) { create(:user, email: 'coach@craftacademy.se') }

      before do
        post '/api/v1/auth',
            params: {
              email: 'coach@craftacademy.se',
              password: 'password',
              password_confirmation: 'password'
            },
            headers: headers
      end

      it 'returns a 422 response status' do
        expect(response).to have_http_status 422
      end

      it 'returns an error message' do
        expect(response_json['errors']['email']).to eq ['has already been taken']
      end
    end

    describe 'an already registered Username' do
      let!(:registered_user) { create(:user, nickname: 'Demo') }

      before do
        post '/api/v1/auth',
            params: {
              email: 'coach@craftacademy.se',
              password: 'password',
              password_confirmation: 'password',
              nickname: 'Demo'
            },
            headers: headers
      end

      it 'returns a 401 response status' do
        expect(response).to have_http_status 401
      end

      it 'returns an error message' do
        expect(response_json['errors']['full_messages']).to eq ['Please choose another Username']
      end
    end
  end
end