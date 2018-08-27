Rails.application.routes.draw do
  namespace :v1 do
    resources :maps, param: :slug do
      resources :layers, param: :slug
      resources :pins
    end
  end
  mount_devise_token_auth_for "User", at: "auth"
end
