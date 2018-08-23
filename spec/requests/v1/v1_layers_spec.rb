require "rails_helper"

RSpec.describe "V1::Layers", type: :request do
  let(:valid_attributes) do
    FactoryBot.attributes_for(:v1_map)
  end

  describe "GET /v1_layers" do
    it "works! (now write some real specs)" do
      map = V1::Map.create! valid_attributes
      get v1_map_layers_path(map_slug: map.to_param)
      expect(response).to have_http_status(:ok)
    end
  end
end
