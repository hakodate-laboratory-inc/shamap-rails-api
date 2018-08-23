require "rails_helper"

RSpec.describe V1::LayersController, type: :controller do
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  let(:valid_session) { {} }

  let(:map) {
    FactoryBot.build(:v1_map)
  }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: { map_slug: map.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      layer = V1::Layer.create! valid_attributes
      get :show, params: { id: layer.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new V1::Layer" do
        expect {
          post :create, params: { v1_layer: valid_attributes }, session: valid_session
        }.to change(V1::Layer, :count).by(1)
      end

      it "renders a JSON response with the new v1_layer" do
        post :create, params: { v1_layer: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json")
        expect(response.location).to eq(v1_layer_url(V1::Layer.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new v1_layer" do
        post :create, params: { v1_layer: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested v1_layer" do
        layer = V1::Layer.create! valid_attributes
        put :update, params: { id: layer.to_param, v1_layer: new_attributes }, session: valid_session
        layer.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the v1_layer" do
        layer = V1::Layer.create! valid_attributes

        put :update, params: { id: layer.to_param, v1_layer: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the v1_layer" do
        layer = V1::Layer.create! valid_attributes

        put :update, params: { id: layer.to_param, v1_layer: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested v1_layer" do
      layer = V1::Layer.create! valid_attributes
      expect {
        delete :destroy, params: { id: layer.to_param }, session: valid_session
      }.to change(V1::Layer, :count).by(-1)
    end
  end
end
