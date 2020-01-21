class CreateProject
  attr_accessor :name, :task_string, :project

  def initialize(name: "", task_string: "")
    @name = name
    @task_string = task_string
  end

  def build
    self.project = Project.new(name: name)
  end

  def convert_string_to_tasks
    titles_with_optional_size = task_string.split("\n")
    titles_with_optional_size.map do |title_with_size|
      title, size, *_ = title_with_size.split(":")
      size ||= 1
      Task.new(title: title, size: size)
    end
  end
end
