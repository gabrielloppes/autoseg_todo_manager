class TodoList < ApplicationRecord
  belongs_to :user

  has_many :taks, dependent: :destroy

  # Rejeitará qualquer task que não obedeca ao critério especificado, neste caso a descricão da task não poderá ser vazia. Utilizando o 'allow_destroy' o modelo associado também será destruído, desta maneira, se uma lista for destruída todas as tasks também serão e da mesma maneira se destruir todas as tasks a lista será destruída.
  accepts_nested_attributes_for :taks, reject_if: proc { |attributes| attributes['description'].blank? }, allow_destroy: true

  # Atribuindo valores de status
  enum status: { personal: 0, shareable: 1 }

  # Name must exists
  validates :name, presence: { message: "Name can't be blank" }
end
