Rails.application.routes.draw do
  resources :todo_lists do
    resources :tasks
  end
end
