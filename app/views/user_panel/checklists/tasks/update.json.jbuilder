# frozen_string_literal: true

json.task do
  json.partial! 'user_panel/checklists/tasks/task', task: @task
end
