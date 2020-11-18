class TodoList < ApplicationRecord
  has_many :tasks, dependent: :destroy
  # belongs_to :user
  
  # Nome da lista deve existir
  # validates :name, presence: { message: "Name can't be blank" }
  
  # # Verifica o status das tasks
  # def status
  #   return 'not-started' if tasks.none?

  #   if tasks.all? { |task| task.complete? }
  #     'complete'
  #   elsif tasks.any? { |task| task.in_progress? || task.complete? }
  #     'in_progress'
  #   else
  #     'not-started'
  #   end
  # end
  
  # # Retorna a porcentagem total da tarefa
  # def percent_complete
  #   return 0 if tasks.none?
  #   ((total_complete.to_f / total_tasks) * 100).round
  # end
  
  # def total_complete
  #   tasks.select { |task| task.complete? }.count
  # end
  
  # # Retorna o total de tasks na lista
  # def total_tasks
  #   tasks.count
  # end
end
