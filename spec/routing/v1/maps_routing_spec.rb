require "rails_helper"

RSpec.describe V1::MapsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/maps").to route_to("v1/maps#index")
    end

    it "routes to #show" do
      expect(get: "/v1/maps/1").to route_to("v1/maps#show", id: "1")
    end

    it "routes to #create" do
      expect(post: "/v1/maps").to route_to("v1/maps#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/v1/maps/1").to route_to("v1/maps#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/v1/maps/1").to route_to("v1/maps#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/v1/maps/1").to route_to("v1/maps#destroy", id: "1")
    end
  end
end
