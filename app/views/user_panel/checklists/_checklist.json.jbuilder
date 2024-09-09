# frozen_string_literal: true

json.extract! checklist, :id, :name

json.links do
  json.checklist_path user_panel_checklist_path(checklist)
  json.thumbnail_url checklist.thumbnail_url
end
