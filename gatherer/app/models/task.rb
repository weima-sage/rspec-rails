class Task < ActiveRecord::Base
  include TasksHelper
  belongs_to :project

  def mark_completed(date = nil)
    self.completed_date = date || Time.current
  end

  def completed_in_recent_time?
    completed_date.present? && TasksHelper.recent_time?(completed_date)
  end

  def points_toward_velocity
    completed_in_recent_time? ? @size : 0
  end
end
