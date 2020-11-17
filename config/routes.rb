Rails.application.routes.draw do
  devise_for :users

  resources :todo_lists do
    #  PUT atualiza um recurso existente
    put :make_it_public
    put :make_it_private
    resources :tasks, only: [:create, :update, :destroy] do
      #  PUT atualiza um recurso existente
      put :set_it_done
      put :set_it_undone
    end
    resources :favorites, only: [:index, :create, :destroy] do
      get '/locate_lists', to: 'todo_lists#locate_list'
    end
  end
  root to: "todo_lists#index"
end
