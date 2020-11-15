class Task < ApplicationRecord
  belongs_to :todo_list

  enum status: { open: 0, closed: 1 }

  # A descricão da task deve existir
  validates :description, presence: { message: "Description can't be blank" }
end
