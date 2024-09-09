# frozen_string_literal: true

json.checklist do
  json.partial! 'checklist', checklist: @checklist
end

json.links do
  json.checklists_path user_panel_checklists_path
end
