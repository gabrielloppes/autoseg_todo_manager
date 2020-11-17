class Task < ApplicationRecord
  belongs_to :todo_list

  validates :status, inclusion: { in:['not-started', 'in-progress', 'complete'] }

  STATUS_OPTION = [
    ['Not started', 'not-started'],
    ['In Progress', 'in-progress'],
    ['COmplete', 'complete']
  ]

  def readable_status
    case status
    when 'not-started'
      'Not started'
    when 'in-progress'
      'In progress'
    when 'complete'
      'Complete'
    end
  end

  def color_status
    case status
    when 'not-started'
      '#000'
    when 'in-progress'
      '#0000ff'
    when 'complete'
      '#00FF00'
    end
  end

  def complete?
    status == 'complete'
  end

  def in_progress
    status == 'in-progress'
  end

  def not_started
    status == 'not-started'
  end
