# frozen_string_literal: true

module ApplicationHelper
  def tabler_icon(name)
    render partial: "icons/tabler/#{name}"
  end
end
