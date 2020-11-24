class TasksController < ApplicationController
  def destroy 
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to edit_todo_list_path(params[:todo_list_id])
  end
end
