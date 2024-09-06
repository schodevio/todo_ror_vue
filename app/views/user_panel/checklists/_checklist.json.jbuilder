# frozen_string_literal: true

json.extract! checklist, :id, :name

json.links do
  json.checklist_path user_panel_checklist_path(checklist)
  json.thumbnail_url "https://picsum.photos/900/600?random=#{rand(1000)}"
end
