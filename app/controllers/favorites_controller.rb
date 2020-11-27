class FavoritesController < ApplicationController
  def update
    favorite = Favorite.where(todo_list: TodoList.find(params[:todo_list]), user: current_user)
      if favorite == []
        # Cria favorito
        Favorite.create(todo_list: TodoList.find(params[:todo_list]), user: current_user)
        @todo_list = TodoList.find(params[:todo_list])
        @todo_list.favorite = true
        @todo_list.save
        @favorite_exists = true
      else
        # Deleta o favorito
        favorite.destroy_all
        @favorite_exists = false
        @todo_list = TodoList.find(params[:todo_list])
        @todo_list.favorite = false
        @todo_list.save
      end
      respond_to do |format|
        format.html {}
        format.js {}
      end
  end
end
