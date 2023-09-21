Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :customers, only: [] do
        post "subscriptions", to: "customers/subscriptions#create"
        get "subscriptions", to: "customers/subscriptions#index"
        patch "subscriptions/:id", to: "customers/subscriptions#update"

      end
    end
  end
end
