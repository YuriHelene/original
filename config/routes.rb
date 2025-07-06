Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users, only: [:show] # ユーザーマイページへのルーティング

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  get 'hello/top' => 'hello#top'
  # get 'tweets' => 'tweets#index'
  # get 'tweets/new' => 'tweets#new'
  # get 'tweets/:id' => 'tweets#show',as: 'tweet' 
  # showはnewより後に書くこと！newがid扱いされてshow アクションに送られてしまう
  root 'hello#top'
  # root 'tweets#index'
  # post 'tweets' => 'tweets#create'
  # patch 'tweets/:id' => 'tweets#update'
  # delete 'tweets/:id' => 'tweets#destroy' 
  # get 'tweets/:id/edit' => 'tweets#edit', as:'edit_tweet'

  resources :tweets do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]

    collection do
      get 'hashtag/:id', to: 'tweets#hashtag', as: 'hashtag'
    end
  end   
  resources :comments, only: [:destroy]

#   $ rails routes
# Prefix       Verb      URI Pattern                   Controller#Action
# tweets       GET       /tweets(.:format)             tweets#index
# new_tweet    GET       /tweets/new(.:format)         tweets#new
#              POST      /tweets(.:format)             tweets#create
# tweet        GET       /tweets/:id(.:format)         tweets#show
#              PATCH     /tweets/:id(.:format)         tweets#update
# edit_tweet   GET       /tweets/:id/edit(.:format)    tweets#edit
#              DELETE    /tweets/:id(.:format)         tweets#destroy


end
