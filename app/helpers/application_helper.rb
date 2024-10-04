# frozen_string_literal: true

module ApplicationHelper
  def blob_to_base64_url(blob, content_type: 'image/png')
    "data:#{content_type};base64, #{Base64.encode64(blob).delete("\n")}"
  end

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
