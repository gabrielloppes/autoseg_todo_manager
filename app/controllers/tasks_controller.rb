class TasksController < ApplicationController
  # Permite alterar o status para feita
  def set_id_done
    @task = Task.find(params[:task_id])
    @task.update(status: :closed)
    flash[:notice] = "'#{task.description}' marked as done"
    redirect_to todo_list_path(@task.todo_list)
  end

  # Permite alterar o status para não feita
  def set_id_undone
    @task = Task.find(params[:task_id])
    @task.update(status: :open)
    flash[:notice] = "'#{task.description}' marked as undone"
    redirect_to todo_list_path(@task.todo_list)
  end

  # Permite deletar uma task
  def destroy 
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to edit_todo_list_path(params[:todo_list_id])
  end
end
