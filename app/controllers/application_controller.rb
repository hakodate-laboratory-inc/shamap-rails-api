class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  def admin?(user)
    ENV["SHAMAP_ADMINS"].split(",").include?(@v1_pin.user)
  end
end
