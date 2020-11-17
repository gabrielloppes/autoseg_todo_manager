class TodoListsController < ApplicationController
  before_action :set_todo_list, only: [:show, :edit, :update, :destroy]

  def index
    # Mostra todas as listas em ordem de criação
    @todo_lists = current_user.todo_lists
  end

  def show
    # Verifica se o usuário que está tentando acessar uma lista possui os requisitos.
    @task = @todo_list.tasks.build
    # if !check_access?
    #   flash[:alert] = "You don't have access to this list"
    #   redirect_to root_path
    # else
    #   return @todo_list, @favorites_ids
    # end
  end

  # No momento da criação o usuário pode criar uma lista e ao mesmo tempo criar tarefas para essa lista
  def new
    @todo_list = current_user.todo_lists.build
  end

  def edit
    # if !check_access?
    #   flash[:alert] = "You don't have access to this list"
    #   redirect_to root_path
    # else
    #   return @todo_list
    # end
  end

  def create

    @todo_list = current_user.todo_lists.build(todo_list_params)

    if @todo_list.save
      redirect_to @todo_list, notice: 'List created'
      render :show, status: :created, location: @todo_list
    else
      render :new
    end
    # @todo_list = TodoList.new(todo_list_params)
    # @todo_list.user = current_user
    # if @todo_list.save
    #   flash[:notice] = 'List was created'
    #   redirect_to @todo_list
    # else
    #   render :new
    # end
  end

  def update
    if @todo_list.update(todo_list_params)
      redirect_to @todo_list, notice: "'#{@todo_list.name}' was update"
      render :show, status: :ok, location: @todo_list
    else
      render :edit
    end
  end

  def destroy
    @todo_list.destroy
    redirect_to todo_lists_url, alert: "List removed"
  end

  # def create_task
  #   @todo_list.update(todo_list_params)
  #   redirect_to @todo_list
  # end

  # Mostra as listas que são publicas e por ordem de criação
  # def locate_lists
  #   @todo_lists = TodoList.where(status: :shareable).where.not(user_id: current_user.id).order(created_at: :desc)
  # end

  # Torna uma lista privada
  def make_it_private
    @todo_list.update(status: :personal)
    flash[:notice] = "'#{@todo_list.name}' is now private"
    redirect_to todo_list_path(@todo_list)
  end

  # Torna uma lista publica
  def make_it_public
    @todo_list.update(status: :shareable)
    flash[:notice] = "'#{@todo_list.name}' is now public"
    redirect_to todo_list_path(@todo_list)
  end

  private

  # Verifica se o usuário possui direito de acesso à uma lista
  # def check_access?
  #   @todo_list = TodoList.find(params[:id])
  #   # Verifica se o usuário é o dono da lista(terá acesso pois é o criador) ou verifica se a lista é pública, desta maneira qualquer usuário terá acesso
  #   (@todo_list.user == current_user || @todo_list.shareable?) ? true : false
  # end

  # def locate_favorites
  #   # Passa um bloco como argumento e usa dentro dentro do método
  #   @favorites = current_user.favorites.map(&:todo_list)
  #   @favorites_ids = []
  #   @favorites.each { |item| @favorites_ids << item.id }
  #   return @favorites_ids
  # end

  def set_todo_list
    @todo_list = current_user.todo_lists.find(params[:id])
  end

  def todo_list_params
    params.require(:todo_list).permit(:name, :status)
  end

  # def set_todo_list_id
  #   @todo_list = TodoList.find(params[:todo_list_id])
  # end
end
