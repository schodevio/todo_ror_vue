# frozen_string_literal: true

module UserPanel
  class ChecklistMailer < ApplicationMailer
    def checklist_export
      @presenter = ::Checklists::ExportPresenter.new(params[:checklist], user: params[:user])
      attachments[@presenter.filename] = @presenter.as_pdf

      mail(
        to: @presenter.user.email,
        subject: "[App Name] Checklist: #{@presenter.checklist.name}"
      )
    end
  end
end
