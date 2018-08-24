require "rails_helper"
require "faker"

RSpec.describe V1::LayersController, type: :controller do
  let(:map) {
    FactoryBot.create(:v1_map, slug: Faker::Address.country_code.downcase.delete(" "))
  }

  let(:valid_attributes) {
    FactoryBot.attributes_for(:v1_layer)
  }

  let(:invalid_attributes) {
    FactoryBot.attributes_for(:invalid_v1_layer)
  }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: { map_slug: map.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      layer = V1::Layer.create! valid_attributes.merge(map: map)
      get :show, params: { map_slug: map.to_param, id: layer.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new V1::Layer" do
        expect {
          post :create, params: { map_slug: map.to_param, v1_layer: valid_attributes }
        }.to change(V1::Layer, :count).by(1)
      end

      it "renders a JSON response with the new v1_layer" do
        post :create, params: { map_slug: map.to_param, v1_layer: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json")
        expect(response.location).to eq(v1_map_layer_url(V1::Layer.last, map_slug: map.to_param))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new v1_layer" do
        post :create, params: { map_slug: map.to_param, v1_layer: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: "NewString",
          slug: "NewString" }
      }

      it "updates the requested v1_layer" do
        layer = V1::Layer.create! valid_attributes.merge(map: map)
        expect {
          put :update, params: { map_slug: map.to_param, id: layer.to_param, v1_layer: new_attributes }
          layer.reload
        }.to change { layer.name }.from("MyString").to("NewString")
      end

      it "renders a JSON response with the v1_layer" do
        layer = V1::Layer.create! valid_attributes.merge(map: map)

        put :update, params: { map_slug: map.to_param, id: layer.to_param, v1_layer: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the v1_layer" do
        layer = V1::Layer.create! valid_attributes.merge(map: map)

        put :update, params: { map_slug: map.to_param, id: layer.to_param, v1_layer: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested v1_layer" do
      layer = V1::Layer.create! valid_attributes.merge(map: map)
      expect {
        delete :destroy, params: { map_slug: map.to_param, id: layer.to_param }
      }.to change(V1::Layer, :count).by(-1)
    end
  end
end
