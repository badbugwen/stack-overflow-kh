Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks:
   "users/omniauth_callbacks"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :edit, :update] do
    member do
      # favorite_user GET /users/:id/favorite(.:format) users#favorite
      get :favorite
    end
  end
  get '/questions/tag_all' =>'questions#tag_all', as: :tag_all
  get '/questions/hashtag/:name' =>'questions#hashtags', as: :hashtag
  root "questions#index"

  resources :questions, only: [:index, :show, :new, :create] do
    resources :solutions, only: [:create] do
      member do
        post :upvote
        post :unupvote
      end
    end
    member do
      post :favorite
      post :unfavorite

      post :upvote
      post :unupvote
    end
  end
end
