Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    get :publish
    collection do
      get :my_posts
    end
  end

  resource :comments, only: [] do
    collection do
      scope '/:post_id' do
        post :add_comment
        patch :update_comment
      end
    end
  end

  resources :likes, only: [] do
    collection do
      get :toggle_likes
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "home#root"
end
