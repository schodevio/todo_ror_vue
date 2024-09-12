# frozen_string_literal: true

json.extract! task, :id, :name, :description, :completed, :position

json.links do
  json.task_path user_panel_checklist_task_path(task.checklist_id, task)
end
