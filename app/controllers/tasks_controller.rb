class TasksController < ApplicationController
  before_action :set_todo_list
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = @todo_list.tasks
  end

  def show
  end

  def new
    @task = @todo_list.tasks.build
  end

  def edit
  end

  def create 
    @task = @todo_list.tasks.build(task_params)
    if @task.save
      redirect_to(@task.todo_list)
    else
      render action: 'new'
    end
  end

  def update 
    if @task.update_attributes(task_params)
      redirect_to(@task.todo_list)
    else
      render action: 'edit'
    end
  end

  def destroy 
    @task.destroy
    redirect_to @todo_list
  end

  
  # # Permite alterar o status para feita
  # def complete
  #   @task = Task.find(params[:task_id])
  #   @task.update(status: :closed)
  #   flash[:notice] = "'#{task.description}' marked as complete"
  #   redirect_to todo_list_path(@task.todo_list)
  # end

  # # Permite alterar o status para não feita
  # def incomplete
  #   @task = Task.find(params[:task_id])
  #   @task.update(status: :open)
  #   flash[:notice] = "'#{task.description}' marked as imcomplete"
  #   redirect_to todo_list_path(@task.todo_list)
  # end

  private

  def set_todo_list
    @todo_list = current_user.todo_lists.find(params[:todo_list_id])
  end

  def set_task
    @task = @todo_list.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description, :status, :todo_list_id)
  end
end
