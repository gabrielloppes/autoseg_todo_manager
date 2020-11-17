class TodoListOverviewComponent < ViewComponent::Base
  with_collection_parameter :todo_list

  attr_reader :todo_list

  def initialize(todo_list:)
    @todo_list = todo_list
  end

  def name
    todo_list.name
  end

  def completion_stats
    "#{display_percent_complete} #{display_breakdown}"
  end

  def status
    todo_list.status
  end

  private

  def display_percent_complete
    "#{todo_list.percent_complete}% complete"
  end

  def display_breakdown
    "(#{todo_list.total_complete}/#{todo_list.total_tasks} tasks)"
  end
end
