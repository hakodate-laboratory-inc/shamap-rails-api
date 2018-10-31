require "rails_helper"
require "faker"

RSpec.describe V1::PinsController, type: :controller do
  let(:map) {
    FactoryBot.create(:v1_map, slug: Faker::Address.country_code.downcase.delete(" ") * 2)
  }

  let(:layer) {
    FactoryBot.create(:v1_layer, map: map, slug: Faker::Address.country_code.downcase.delete(" ") * 2)
  }

  let(:valid_attributes) {
    FactoryBot.attributes_for(:v1_pin, layer_id: layer.id)
  }

  let(:valid_post_attributes) {
    valid_attributes.merge({ context: JSON.generate(valid_attributes[:context]) })
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  let(:user) {
    FactoryBot.create(:user)
  }

  before { request.env["HTTP_ACCEPT"] = "application/json" }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: { map_slug: map.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      pin = V1::Pin.create! valid_attributes.merge(map: map, layer: layer, user: user)
      get :show, params: { map_slug: map.to_param, id: pin.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    before do
      login_user user
    end

    context "with valid params" do
      it "creates a new V1::Pin" do
        expect {
          post :create, params: { map_slug: map.to_param, v1_pin: valid_post_attributes }
        }.to change(V1::Pin, :count).by(1)
      end

      it "renders a JSON response with the new v1_pin" do
        post :create, params: { map_slug: map.to_param, v1_pin: valid_post_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json")
        expect(response.location).to eq(v1_map_pin_url(id: V1::Pin.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new v1_pin" do
        post :create, params: { map_slug: map.to_param, v1_pin: invalid_attributes }
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
        { layer_id: layer.id,
          location: "POINT(41.841911 140.766970)",
          context: JSON.generate({ text: "FUN" }) }
      }

      it "updates the requested v1_pin" do
        pin = V1::Pin.create! valid_attributes.merge(map: map, layer: layer, user: user)
        expect {
          put :update, params: { map_slug: map.to_param, id: pin.to_param, v1_pin: new_attributes }
          pin.reload
        }.to change { pin.context }.from({ "text" => "hello" }).to({ "text" => "FUN" })
      end

      it "renders a JSON response with the v1_pin" do
        pin = V1::Pin.create! valid_attributes.merge(map: map, layer: layer, user: user)

        put :update, params: { map_slug: map.to_param, id: pin.to_param, v1_pin: valid_post_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the v1_pin" do
        pin = V1::Pin.create! valid_attributes.merge(map: map, layer: layer, user: user)

        put :update, params: { map_slug: map.to_param, id: pin.to_param, v1_pin: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      login_user user
    end

    it "destroys the requested v1_pin" do
      pin = V1::Pin.create! valid_attributes.merge(map: map, layer: layer, user: user)
      expect {
        delete :destroy, params: { map_slug: map.to_param, id: pin.to_param }
      }.to change(V1::Pin, :count).by(-1)
    end
  end
end
