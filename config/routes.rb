Rails.application.routes.draw do
  devise_for :users
  resources :todo_lists do
    put :make_public
    put :make_personal
    resources :tasks, only: [:create, :destroy]
  end
  resources :favorites, only: [:update, :index]
  resource :progress_bar, only: [:show]
  
  root to: 'todo_lists#index'
end
