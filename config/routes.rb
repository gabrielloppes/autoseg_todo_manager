Rails.application.routes.draw do
  devise_for :users

  resources :todo_lists do
    #  PUT atualiza um recurso existente
    put :make_it_public
    put :make_it_private
    put :create_task
    resources :taks, only: [:set_it_done, :set_it_undone, :destroy] do
      #  PUT atualiza um recurso existente
      put :set_it_done
      put :set_it_undone
    end
    resources :favorites, only: [:index, :create, :destroy]
    get '/locate_list', to: 'todo_list#locate_list'
  end
  root to: "todo_list#index"
end
