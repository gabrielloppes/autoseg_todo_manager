class TodoList < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_many :favorites, dependent: :destroy

  enum status: { personal: 0, shareable: 5 }

  validates_length_of :title, within: 1..26, on: :create, message: "must be present"
  
  # Título da lista deve existir
  validates :title, presence: { message: "Title can't be blank" }
  
  # Verifica o status das tasks
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
  
  def status
    case percent_complete.to_i
    when 0
      'Não iniciada'
    when 100
      'Completa'
    else
      'Em progresso'
    end
  end
  
  def badge_color
    case percent_complete.to_i
    when 0
      'not-started'
    when 100
      'complete'
    else
      'in-progress'
    end
  end
  
end
