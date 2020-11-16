class FavoritesController < ApplicationController
  # Mostra todas as listas marcadas como favoritas(pessoais)
  def index 
    @favorites = current_user.favorites.map(&:todo_list)
  end

  def create 
    @favorite = Favorite.create(todo_list_id: params[:todo_list_id])
    @favorite.user = current_user
    @favorite.save
    flash[:notice] = "'#{@todo_list.name}' marked as favorite"
    redirect_to todo_list_path(@favorite.todo_list)
  end

  # Uusário pode desmarcar uma lista, a lista irá voltar à pagina inicial com o 'redirect_back'
  def destroy
    @favorite = Favorite.find_by(todo_list_id: params[:todo_list_id], user_id: current_user.id)
    @favorite.destroy
    flash[:notice] = "#{@todo_list.name} 'unmarked as favorite'"
    redirect_back(fallback_location: todo_list_path(params[:todo_list_id]))
  end
end
