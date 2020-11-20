# frozen_string_literal: true

class TaskReflex < ApplicationReflex
  def mark_complete
    task = Task.find(element.dataset.id)
    task.update(completed: true, completed_at: Time.now)
  end

  def mark_incomplete
    task = Task.find(element.dataset.id)
    task.update(completed: false, completed_at: nil)
  end

end
