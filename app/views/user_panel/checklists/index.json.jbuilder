# frozen_string_literal: true

json.checklists @checklists do |checklist|
  json.partial! 'user_panel/checklists/checklist', checklist: checklist
end

json.links do
  json.checklists_path user_panel_checklists_path
end
