Rails.application.routes.draw do
  resources :pictures do
    collection do
      post :confirm
    end
  end
  resources :users, only: [:new,:create,:show ,:edit,:update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy ]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  get "/users/favorite/:id"  => 'users#favorite_index', as: 'favorite_index'
end
