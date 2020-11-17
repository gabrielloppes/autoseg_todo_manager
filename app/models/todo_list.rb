class TodoList < ApplicationRecord
  belongs_to :user
  
  has_many :tasks, dependent: :destroy
  
  # Rejeitará qualquer task que não obedeca ao critério especificado, neste caso a descricão da task não poderá ser vazia. Utilizando o 'allow_destroy' o modelo associado também será destruído, desta maneira, se uma lista for destruída todas as tasks também serão e da mesma maneira se destruir todas as tasks a lista será destruída.
  accepts_nested_attributes_for :tasks, reject_if: proc { |attributes| attributes['description'].blank? }, allow_destroy: true
  
  # Atribuindo valores de status
  enum status: { personal: 0, shareable: 5 }
  
  # Nome da lista deve existir
  validates :name, presence: { message: "Name can't be blank" }
  
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
  
  # Retorna a porcentagem total da tarefa
  def percent_complete
    return 0 if task.none?
    ((total_complete.to_f / total_tasks) * 100).round
  end
  
  def total_complete
    tasks.select { |task| task.complete }.count
  end
  
  # Retorna o total de tasks na lista
  def total_tasks
    tasks.count
  end
end
