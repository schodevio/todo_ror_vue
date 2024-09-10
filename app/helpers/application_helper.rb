# frozen_string_literal: true

module ApplicationHelper
  def safe_attachment_path(attachment)
    rails_blob_path(attachment) if attachment.attached?
  end

  def tabler_icon(name)
    render partial: "icons/tabler/#{name}"
  end
end
