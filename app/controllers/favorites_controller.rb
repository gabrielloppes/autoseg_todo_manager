class FavoritesController < ApplicationController
  # Mostra todas as listas marcadas como favoritas
  def index 
    @favorires = current_user.favorites.collect(&:todo_list)
  end

  # Permite criar uma lista como favorite
  def create
    @favorite = Favorite.create(todo_list_id: params[:todo_list_id])
    @favorite.user = current_user
    @favorite.save
    flash[:notice] = "List marked as favorite"
    redirect_to todo_list_path(@favorite.todo_list)
  end

  # Quando o usuário desmarcar uma lista como 'favorita' ela voltará para a pagina principal com o 'redirect_back']
  def destroy
    @favorite = Favorite.find_by(todo_list_id: params[:todo_list_id], user_id: current_user.id)
    @favorite.destroy
    flash[:alert] = "List was removed from favorites"
    redirect_back(fallback_location: todo_list_path(params[:todo_list_id]))
  end
end
