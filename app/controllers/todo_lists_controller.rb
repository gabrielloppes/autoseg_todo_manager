class TodoListsController < ApplicationController
  def index
    # Mostra todas as listas em ordem de criação
    @todo_lists = current_user.todo_lists.order(created_at: :desc)
  end

  def show

  end

  # No momento da criação o usuário pode criar uma lista e ao mesmo tempo criar tarefas para essa lista
  def new
    @todo_list = TodoList.new
    @todo_list.task.build
  end

  def create
    @todo_list = TodoList.new(todo_list_params)
    @todo_list.user = current_user
    if @todo_list.save
      flash[:notice] = 'List was created'
      redirect_to todo_lists_path
    else
      render :new
    end
  end

  def edit
    if !check_access?
      flash[:alert] = "You don't have access to this list"
      redirect_to root_path
    end
  end

  def update
    if @todo_list.update(todo_list_params)
      redirect_to todo_lists_path
      flash[:notice] = "'#{@todo_list.name}' was update"
    else
      render :edit
    end
  end

  # Torna uma lista privada
  def make_it_private

  end

  # Torna uma lista publica
  def make_it_public

  end

  def destroy

  end

  def create_task

  end

  def locate_lists

  end

  private

  # Verifica se o usuário possui direito de acesso à uma lista
  def check_access

  end

  def locate_favorites

  end

  def set_todo_list

  end

  def todo_list_params

  end

  def set_todo_list_id

  end
end
