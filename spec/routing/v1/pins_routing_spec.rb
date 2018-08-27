require "rails_helper"

RSpec.describe V1::PinsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/v1/maps/testmap/pins").to route_to("v1/pins#index", map_slug: "testmap")
    end


    it "routes to #show" do
      expect(:get => "/v1/maps/testmap/pins/1").to route_to("v1/pins#show", map_slug: "testmap", id: "1")
    end


    it "routes to #create" do
      expect(:post => "/v1/maps/testmap/pins").to route_to("v1/pins#create", map_slug: "testmap")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/maps/testmap/pins/1").to route_to("v1/pins#update", map_slug: "testmap", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/maps/testmap/pins/1").to route_to("v1/pins#update", map_slug: "testmap", id: "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/maps/testmap/pins/1").to route_to("v1/pins#destroy", map_slug: "testmap", id: "1")
    end

  end
end
