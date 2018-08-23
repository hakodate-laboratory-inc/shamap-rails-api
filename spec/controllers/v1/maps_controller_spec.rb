require "rails_helper"

RSpec.describe V1::MapsController, type: :controller do
  let(:valid_attributes) {
    FactoryBot.attributes_for(:v1_map)
  }

  let(:invalid_attributes) {
    skip("Skip")
  }

  let(:user) {
    FactoryBot.create(:user)
  }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      map = V1::Map.create! valid_attributes
      get :show, params: { id: map.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      before do
        login_user user
      end

      it "creates a new V1::Map" do
        expect {
          post :create, params: { v1_map: valid_attributes }
        }.to change(V1::Map, :count).by(1)
      end

      it "renders a JSON response with the new v1_map" do
        post :create, params: { v1_map: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json")
        expect(response.location).to eq(v1_map_url(V1::Map.last))
      end
    end

    context "with invalid params" do
      before do
        login_user user
      end

      it "renders a JSON response with errors for the new v1_map" do
        post :create, params: { v1_map: invalid_attributes }
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

      before do
        login_user user
      end

      it "updates the requested v1_map" do
        map = V1::Map.create! valid_attributes
        put :update, params: { id: map.to_param, v1_map: new_attributes }
        map.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the v1_map" do
        map = V1::Map.create! valid_attributes

        put :update, params: { id: map.to_param, v1_map: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid params" do
      before do
        login_user user
      end

      it "renders a JSON response with errors for the v1_map" do
        map = V1::Map.create! valid_attributes

        put :update, params: { id: map.to_param, v1_map: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      login_user user
    end

    it "destroys the requested v1_map" do
      map = V1::Map.create! valid_attributes
      expect {
        delete :destroy, params: { id: map.to_param }
      }.to change(V1::Map, :count).by(-1)
    end
  end
end
