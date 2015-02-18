Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resources :subs
  resources :posts do
    resources :comments, only: [:new]
    member do
      get 'upvote'
      get 'downvote'
    end
  end
  resources :comments, only: [:create, :show] do
    member do
      get 'upvote'
      get 'downvote'
    end
  end
  resource :session, only: [:new, :create, :destroy]
end
