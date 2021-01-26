Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    collection do
      get :my_posts
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "home#root"
end