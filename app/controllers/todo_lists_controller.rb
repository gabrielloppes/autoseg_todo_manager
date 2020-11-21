class TodoListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_list, only: [:show, :edit, :update, :destroy]

  
  # Mostra as listas no escopo do usuário
  def index
    @todo_lists = current_user.todo_lists.order(created_at: :asc)
  end

  # Permite criar tarefas no escopo do usuário
  def show
    @task = @todo_list.tasks.build
  end

  # Permite criar uma nova lista no escopo do usuário
  def new
    @todo_list = current_user.todo_lists.build
  end

  # Permite editar uma lista de o id do usuário for igual ao id de current_user, do contrário será negado o acesso
  def edit
  end

  def create
    @todo_list = current_user.todo_lists.build(todo_list_params)

    respond_to do |format|
      if @todo_list.save
        format.html { redirect_to @todo_list, notice: "'#{@todo_list.title}' created" }
        format.json { render :show, status: :created, location: @todo_list }
      else
        format.html { render :new }
        format.json { render json: @todo_list.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @todo_list.update(todo_list_params)
        format.html { redirect_to @todo_list, notice: 'Todo list was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo_list }
      else
        format.html { render :edit }
        format.json { render json: @todo_list.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @todo_list.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Todo list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_todo_list
      @todo_list = TodoList.find(params[:id])
    end

    # Permite apenas parâmetros confiáveis
    def todo_list_params
      params.require(:todo_list).permit(:title)
    end
end
