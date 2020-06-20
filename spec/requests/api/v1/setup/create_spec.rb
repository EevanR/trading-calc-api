# frozen_string_literal: true

RSpec.describe 'POST /api/v1/trades', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'Succesfully creates setup' do
    before do
      post '/api/v1/setups',
      params: {
        setup: {
          name: "Short Strategy",
          reqOne: "Prerequisite one",
          reqTwo: "Prerequisite two",
          reqThree: "You can have up to 10 pre reqs"
        }
      },
      headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns the name of strategy' do
      expect(response_json['name']).to eq "Short Strategy"
    end
  end

  describe 'Unsuccesfully creates setup when no name submitted' do
    before do
      post '/api/v1/setups',
      params: {
        setup: {
          reqOne: "Prerequisite one",
          reqTwo: "Prerequisite two",
          reqThree: "You can have up to 10 pre reqs"
        }
      },
      headers: headers
    end

    it 'returns a 422 response status' do
      expect(response).to have_http_status 422
    end

    it 'returns an error message' do
      expect(response_json['errors'][0]).to eq "Name can't be blank"
    end
  end

  describe 'Unsuccesfully creates setup when user not logged in' do
    before do
      post '/api/v1/setups',
      params: {
        setup: {
          name: "Short Strategy",
          reqOne: "Prerequisite one",
          reqTwo: "Prerequisite two",
          reqThree: "You can have up to 10 pre reqs"
        }
      }
    end

    it 'returns a 401 response status' do
      expect(response).to have_http_status 401
    end

    it 'returns a not authorized error message' do
      expect(response_json['errors'][0]).to eq "You need to sign in or sign up before continuing."
    end
  end

end