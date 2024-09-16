# frozen_string_literal: true

class RenderPDFService
  include Callable

  attr_reader :presenter, :scope, :views

  def initialize(presenter, views:)
    @presenter = presenter
    @views = views
  end

  def call
    WickedPdf.new.pdf_from_string(
      body_content,
      header: { content: header_content },
      footer: { content: footer_content }
    )
  end

  private

  def header_content
    ApplicationController.render(
      template: "#{views}/header",
      locals: { presenter: presenter },
      layout: false
    )
  end

  def body_content
    ApplicationController.render(
      template: "#{views}/body",
      locals: { presenter: presenter },
      layout: false
    )
  end

  def footer_content
    ApplicationController.render(
      template: "#{views}/footer",
      locals: { presenter: presenter },
      layout: false
    )
  end
end
