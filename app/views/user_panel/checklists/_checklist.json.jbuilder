# frozen_string_literal: true

json.extract! checklist, :id, :name

json.links do
  json.checklist_path user_panel_checklist_path(checklist)
  json.export_checklist_pdf_path export_user_panel_checklist_path(checklist, format: :pdf)
  json.send_email_checklist_path send_email_user_panel_checklist_path(checklist)
  json.thumbnail_url safe_attachment_path(checklist.thumbnail)
end
