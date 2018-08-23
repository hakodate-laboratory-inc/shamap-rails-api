Rails.application.routes.draw do
  namespace :v1 do
    resources :maps, param: :slug do
      resources :layers
    end
  end
  mount_devise_token_auth_for "User", at: "auth"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
