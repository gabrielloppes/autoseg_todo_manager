class TasksController < ApplicationController
  before_action :set_todo_list
  before_action :set_task, only: [:show, :destroy]

  def create
    @task = @todo_list.tasks.build(task_params)

    if @task.save
      redirect_to (@task.todo_list)
    else
      redirect_to root_path
    end
  end

  def destroy
    @task.destroy
    redirect_to @todo_list
  end

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