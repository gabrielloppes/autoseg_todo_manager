class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_list
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  
  # def index
  #   @tasks = @todo_list.tasks
  # end

  
  # def show
  # end

  
  # def new
  #   @task = @todo_list.tasks.build
  # end

  
  # def edit
  # end

  
  def create
    @task = @todo_list.tasks.build(task_params)

    if @task.save
      redirect_to(@task.todo_list)
    else
      render action: 'new'
    end
  end

  
  # def update
  #   if @task.update_attributes(task_params)
  #     redirect_to([@task.todo_list, @task], notice: 'Task was successfully updated.')
  #   else
  #     render action: 'edit'
  #   end
  # end

  
  def destroy
    @task.destroy
    redirect_to @todo_list
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_list
      @todo_list = TodoList.find(params[:todo_list_id])
    end

    def set_task
      @task = @todo_list.tasks.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:description, :completed, :completed_at, :todo_list_id)
    end
end
