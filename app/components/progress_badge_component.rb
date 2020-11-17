class ProgressBadgeCompoennt < ViewComponent::Base

  attr_reader :status
  
  def def initialize(status:)
    @status = status
  end

  def badge_color
    case status
    when 'not-started'
      '#000'
    when 'in-progress'
      '#0000ff'
    when 'complete'
      '#00FF00'
    end
  end
end