require "rails_helper"

describe CreateProject do
  it "creates a project given a name" do
    project_name = "Project Runaway"
    creator = CreateProject.new(name: project_name)
    creator.build
    expect(creator.project.name).to eq(project_name)
  end

  describe "task string passing" do
    def task_title_size_and_string(title:, size: nil)
      task_string = size.nil? ? title : "#{title}:#{size}"
      [title, size, task_string]
    end


    it "handles an empty string" do
      creator = CreateProject.new(name: "Test", task_string: "")
      tasks = creator.convert_string_to_tasks
      expect(tasks).to be_empty
    end
    it "handles a single string" do
      task_title, _, task_string = task_title_size_and_string(title: "task with no size")
      creator = CreateProject.new(name: "Test", task_string: task_string)
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1)
      first_task = tasks[0]
      expect(first_task.title).to eq(task_title)
      expect(first_task.size).to eq(1)
    end
    it "handles a single string with size" do
      task_title, task_size, task_string = task_title_size_and_string(title: "task with size 3", size: 3)
      creator = CreateProject.new(name: "Test", task_string: task_string)
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1)
      first_task = tasks[0]
      expect(first_task.title).to eq(task_title)
      expect(first_task.size).to eq(task_size)
    end

    it "handles multiple tasks" do
      task_title1, task_size1, task_string1 = task_title_size_and_string(title: "t1", size: 3)
      task_title2, task_size2, task_string2 = task_title_size_and_string(title: "t2", size: 2)
      task_strings = [task_string1, task_string2].join("\n")
      creator = CreateProject.new(name: "Test", task_string: task_strings)
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(2)
      first_task, second_task = tasks
      expect(first_task.title).to eq(task_title1)
      expect(first_task.size).to eq(task_size1)
      expect(second_task.title).to eq(task_title2)
      expect(second_task.size).to eq(task_size2)
    end

    it "attaches tasks to project" do
      task_title1, task_size1, task_string1 = task_title_size_and_string(title: "t1", size: 3)
      task_title2, task_size2, task_string2 = task_title_size_and_string(title: "t2", size: 2)
      task_strings = [task_string1, task_string2].join("\n")
      creator = CreateProject.new(name: "Test", task_string: task_strings)
      creator.create
      expect(creator.project.tasks.size).to eq(2)
      expect(creator.project).not_to be_a_new_record

    end
  end
end
