Rails.application.routes.draw do
  resources :pictures do
    collection do
      post :confirm
    end
  end
  resources :users, only: [:new,:create,:show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy ]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  get "/users/favorite/:id"  => 'users#favorites'
end
