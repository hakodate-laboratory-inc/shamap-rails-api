class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  def admin?(email)
    ENV["SHAMAP_ADMINS"].split(",").include?(email)
  end
end
