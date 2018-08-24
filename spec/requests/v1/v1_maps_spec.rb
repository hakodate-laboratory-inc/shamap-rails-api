require "rails_helper"

RSpec.describe "V1::Maps", type: :request do
  describe "GET /v1_maps" do
    it "works! (now write some real specs)" do
      get v1_maps_path
      expect(response).to have_http_status(:ok)
    end
  end
end
