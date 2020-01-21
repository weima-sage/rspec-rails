module TasksHelper
  include ProjectManagement

  def self.recent_time?(time)
    time >= VELOCITY_COUNTING_WEEKS.weeks.ago
  end

  def self.size_sum(tasks_to_sum)
    tasks_to_sum.to_a.inject(0) { |current, task| current + task.size }
  end

  def self.velocity_sum(tasks_to_sum)
    tasks_to_sum.to_a.inject(0) { |current, task| current + task.points_toward_velocity }
  end

  def total_size
    TasksHelper.size_sum(tasks)
  end

end
