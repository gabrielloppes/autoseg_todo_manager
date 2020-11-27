class TodoListsController < ApplicationController
  # before_action :find_favorites, only: [:show, :find]
  before_action :set_todo_list, only: [:show, :update, :destroy]
  before_action :set_todo_list_id, only: [:make_public, :make_personal]
  def index
    @todo_lists = current_user.todo_lists.order(created_at: :asc)
    @favorites = Favorite.where(todo_list: TodoList.find(@todo_lists.ids), user: current_user)
  end
  
  def show
    @task = @todo_list.tasks.build
    # Fará a ação negativa, caso a lista nãpo for compartilhável ou o usuário que está acessando não for o usuário criador, ele negará o acesso.
    unless @todo_list.shareable? || @todo_list.user == current_user
      flash[:alert] = "Você não tem permissão"
      redirect_to todo_lists_path

      @favorite_exists = Favorite.where(todo_list: @todo_list, user: current_user) == [] ? false : true
      @todo_list.favorite = true
      @todo_list.save
    end
  end
  
  def new
    @todo_list = TodoList.new
    @todo_list.tasks.build
  end
  
  def edit
    @todo_list = current_user.todo_lists.find(params[:id])
    unless @todo_list.shareable? || @todo_list.user == current_user
      flash[:alert] = "Você não tem acesso"
      redirect_to todo_lists_path
    end
  end
  
  def create
    @todo_list = TodoList.new(todo_list_params)
    @todo_list.user = current_user
    if @todo_list.save
      flash[:notice] = "'#{@todo_list.title}', criada com sucesso"
      redirect_to @todo_list
    else
      render :new
    end
  end
  
  def update
    if @todo_list.update(todo_list_params)
      redirect_to @todo_list
    else
      render :edit
    end
  end
  
  def destroy
    @todo_list = current_user.todo_lists.find(params[:id])
    @todo_list.destroy
    flash[:alert] = "'#{@todo_list.title}', deletada com sucesso"
    redirect_to todo_lists_path
  end
  
  def find
    @todo_list = TodoList.where(status: :shareable).where.not(user_id: current_user.id).order(created_at: :asc)
  end
  
  def make_public
    @todo_list.update(status: :shareable)
    flash[:alert] = "'#{@todo_list.title}', agora é publica"
    redirect_to todo_list_path(@todo_list)
  end
  
  def make_personal
    @todo_list.update(status: :personal)
    flash[:alert] = "'#{@todo_list.title}', agora é privada"
    redirect_to todo_list_path(@todo_list)
  end
  
  private
  
  def set_todo_list_id
    @todo_list = TodoList.find(params[:todo_list_id])
  end
  
  def set_todo_list
    @todo_list = TodoList.find(params[:id])
  end
  
  # Permite apenas parâmetros confiáveis
  def todo_list_params
    params.require(:todo_list).permit(:title, :status, :favorite)
  end
end