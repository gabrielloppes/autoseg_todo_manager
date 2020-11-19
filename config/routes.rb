Rails.application.routes.draw do
  resources :todo_lists do
    resources :tasks
  end
  resource :progress_bar, only: [:show]

  root to: 'todo_lists#index'
end
