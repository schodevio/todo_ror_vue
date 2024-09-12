# frozen_string_literal: true

json.checklist do
  json.partial! 'user_panel/checklists/checklist', checklist: @checklist
end
