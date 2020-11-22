class Task < ApplicationRecord
  belongs_to :todo_list

  validates :description, presence: { message: "Description can't be blank" }

  before_destroy do
    @todo_list = self.todo_list
  end

  after_destroy do
    unless @todo_list.tasks.any?
      @todo_list.destroy
    end
  end

  # Esse scope retornará as tasks que estão como completas
  scope :completed, -> do
    where(completed: true)
  end
end
