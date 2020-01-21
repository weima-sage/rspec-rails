require "rails_helper"

RSpec.describe "add projects" do
  it "allows user to create project with tasks" do
    visit new_project_path
    fill_in "Name", with: "Project Runaway"
    fill_in "Tasks", with: "Task 1:3\nTask 2:5"
    click_on("Create Project")
    visit projects_path
    expect(page).to have_content("Project Runaway")
    expect(page).to have_content("8")
  end
end
