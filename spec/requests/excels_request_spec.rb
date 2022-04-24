require 'rails_helper'

RSpec.describe "Excels", type: :request do

  describe "GET /show" do
    it "returns http success" do
      get "/excels/show"
      expect(response).to have_http_status(:success)
    end
  end

end
