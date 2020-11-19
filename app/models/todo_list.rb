class TodoList < ApplicationRecord
  has_many :tasks, dependent: :destroy
  # belongs_to :user
  
  # Nome da lista deve existir
  # validates :name, presence: { message: "Name can't be blank" }
  
  # # Verifica o status das tasks
  def status
    return 'not-started' if tasks.none?

    if tasks.all? { |task| task.complete? }
      'complete'
    elsif tasks.any? { |task| task.in_progress? || task.complete? }
      'in_progress'
    else
      'not-started'
    end
  end
  
  # Retorna a porcentagem da tarefa
  def percent_complete
    return 0 if total_tasks == 0
    (100 * completed_tasks.to_f / total_tasks).round(1)
  end
  
  # Retorna o total de tasks completas
  def completed_tasks
    @completed_tasks ||= tasks.completed.count
  end
  
  # Retorna o total de tasks na lista
  def total_tasks
    @total_tasks ||=tasks.count
  end
end
