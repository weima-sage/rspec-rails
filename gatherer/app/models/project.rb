class Project < ActiveRecord::Base
  include TasksHelper
  include ProjectManagement
  has_many :tasks

  def remaining_size
    TasksHelper.size_sum(incomplete_tasks)
  end

  def completed_velocity
    TasksHelper.velocity_sum(tasks)
  end

  def incomplete_tasks
    tasks.to_a.reject(&:complete?)
  end

  def done?
    incomplete_tasks.empty?
  end

  def current_rate
    completed_velocity.fdiv(WORKING_DAYS_PER_WEEK)
  end

  def projected_days_remaining
    remaining_size / current_rate
  end

  def on_schedule?
    projected_days_remaining.days.from_now <= due_date
  end


end
