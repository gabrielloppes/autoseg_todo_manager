Rails.application.routes.draw do
  devise_for :users
  root to: "todo_list#index"
end
