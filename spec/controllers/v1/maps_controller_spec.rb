require "rails_helper"

RSpec.describe V1::MapsController, type: :controller do
  let(:valid_attributes) {
    FactoryBot.attributes_for(:v1_map)
  }

  let(:invalid_attributes) {
    FactoryBot.attributes_for(:invalid_v1_map)
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
      get :show, params: { slug: map.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    before do
      login_user user
    end

    context "with valid params" do
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
      it "renders a JSON response with errors for the new v1_map" do
        post :create, params: { v1_map: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PUT #update" do
    before do
      login_user user
    end

    context "with valid params" do
      let(:new_attributes) {
        { title: "NewString",
          slug: "NewString",
          description: "NewText" }
      }

      it "updates the requested v1_map" do
        map = V1::Map.create! valid_attributes
        expect {
          put :update, params: { slug: map.to_param, v1_map: new_attributes }
          map.reload
        }.to change { map.title }.from("MyString").to("NewString")
      end

      it "renders a JSON response with the v1_map" do
        map = V1::Map.create! valid_attributes

        put :update, params: { slug: map.to_param, v1_map: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the v1_map" do
        map = V1::Map.create! valid_attributes

        put :update, params: { slug: map.to_param, v1_map: invalid_attributes }
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
        delete :destroy, params: { slug: map.to_param }
      }.to change(V1::Map, :count).by(-1)
    end
  end
end
