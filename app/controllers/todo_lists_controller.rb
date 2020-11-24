class TodoListsController < ApplicationController
  before_action :locate_favorites, only: [:show :discovery]
  before_action :set_todo_list, only: [:update :destroy]
  before_action :set_todo_list_id, only: [:create_task, :make_public, :make_private]

  
  # Mostra as listas no escopo do usuário
  def index
    @todo_lists = current_user.todo_lists.order(created_at: :asc)
  end

  # Irá verificar se o usuário possui acesso, baseado no método 'check_access?'
  def show
    if !check_access?
      flash[:alert] = "You don't have access to this list"
      redirect_to root_path
    else
      return @todo_list, @favorites_ids
    end
  end

  # No momento do criação de uma lista, o usuário pode criar várias tasks
  def new
    @todo_list = TodoList.new
    @todo_list.tasks.build
  end

  # Permite editar uma lista de o id do usuário for igual ao id de current_user, do contrário será negado o acesso
  def edit
    if !check_access?
      flash[:alert] = "You don't have access to this list"
      redirect_to root_path
    else
      return @todo_list
    end
  end

  def create
    @todo_list = TodoList.new(todo_list_params)
    @todo_list.user = current_user
    if @todo_list.save
      flash[:notice] = "List created"
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
    @todo_list.destroy
    redirect_to todo_lists_path
  end

  # Permite criar tasks nestadas
  def create_task
    @todo_list.update(todo_list_params)
    redirect_to @todo_list
  end

  def locate
    @todo_list = TodoList.where(status: :shareable).where.not(user_id: current_user.id).order(created_at: :asc)
  end

  # Tornar uma lista particular / privada
  def make_private
    @todo_List.update(status: :personal)
    flash[:notice] = "'#{@todo_list.title}' is now private"
    redirect_to @todo_list_path(@todo_List)
  end

  # Tornar uma lista publica
  def make_public
    @todo_List.update(status: :shareable)
    flash[:notice] = "'#{@todo_list.title}' is now public"
    redirect_to @todo_list_path(@todo_List)
  end

  private
  # Cria um método para verificar o acesso do usuário.
    def check_access?
      @todo_list = TodoList.find(params[:id])
      (@todo_list.user == current_user || @todo_list.shareable?) ? true : false
    end

    def locate_favorites
      @favorites = current_user.favorites.map(&:todo_list)
      @favorites_ids = []
      @favorites.each { |item| @favorites_ids.push(item.id) }
      return @favorites_ids
    end

    def set_todo_list
      @todo_list = TodoList.find(params[:id])
    end

    # Permite apenas parâmetros confiáveis
    def todo_list_params
      params.require(:todo_list).permit(:title)
    end

    def set_todo_list_id
      @todo_list = TodoList.find(params[:todo_list_id])
    end
end
