# frozen_string_literal: true

module ApplicationHelper
  def url_to_qrcode(url)
    RQRCode::QRCode.new(url).as_svg(module_size: 4)
  end

  def safe_attachment_path(attachment)
    rails_blob_path(attachment) if attachment.attached?
  end

  def tabler_icon(name)
    render partial: "icons/tabler/#{name}"
  end
end
