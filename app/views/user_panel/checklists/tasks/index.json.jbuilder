# frozen_string_literal: true

json.tasks @tasks do |task|
  json.partial! 'user_panel/checklists/tasks/task', task: task
end

json.links do
  json.tasks_path user_panel_checklist_tasks_path(@checklist)
end
