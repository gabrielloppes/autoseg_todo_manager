Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do 
    root to: 'todo_lists#index'
  end
  resources :todo_lists do
    put :make_public
    put :make_personal
    resources :tasks, only: [:create, :destroy]
  end
  resources :favorites, only: [:update, :index]
  resource :progress_bar, only: [:show]
end
