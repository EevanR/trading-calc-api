require 'rails_helper'

RSpec.describe "TwitterStreams", type: :request do

  describe "GET /get_all_rules" do
    it "returns http success" do
      get "/twitter_stream/get_all_rules"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /set_rules" do
    it "returns http success" do
      get "/twitter_stream/set_rules"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /delete_all_rules" do
    it "returns http success" do
      get "/twitter_stream/delete_all_rules"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /setup_rules" do
    it "returns http success" do
      get "/twitter_stream/setup_rules"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /stream_connect" do
    it "returns http success" do
      get "/twitter_stream/stream_connect"
      expect(response).to have_http_status(:success)
    end
  end

end
