require 'rails_helper'

RSpec.describe "Setups", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/setups/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/setups/destroy"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/setups/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/setups/show"
      expect(response).to have_http_status(:success)
    end
  end

end
