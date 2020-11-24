class FavoritesController < ApplicationController
  def update
    @favorite = Favorite.where(todo_list: TodoList.find(params[:todo_list]), user: current_user)
    if favorite == []
      # Cria o favorito
      Favorite.create(todo_list: TodoList.find(params[:todo_list]), user: current_user)
      @favorite_exists = true
    else
      # Deleta o favorito(s)
      favorite.destroy_all
      @favorite_exists = false
      respond_to do |format|
        format.html {}
        format.js {}
      end
    end
  end
end
