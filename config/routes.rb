Rails.application.routes.draw do
  resources :photos
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :photos, except: [:new, :edit]

      post "signup", to: "auth#signup"
      post "login", to: "auth#login"
      post "logout", to: "auth#logout"
    end
  end
end
