require "rails_helper"

RSpec.describe V1::Auth::RegistrationsController, type: :controller do
  let(:user) {
    FactoryBot.attributes_for(:user)
  }

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "POST #create" do
    it "Success to create user" do
      expect {
        post :create, params: user
      }.to change { User.count }.by(1)
    end
  end
end
