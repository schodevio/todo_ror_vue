# frozen_string_literal: true

module Checklists
  class ExportPresenter
    attr_reader :checklist, :user

    delegate :tasks, to: :checklist

    def initialize(checklist, user:)
      @checklist = checklist
      @user = user
    end

    def filename
      "#{name_param}_#{current_time_param}.pdf"
    end

    def as_pdf
      RenderPDFService.call(self, views: 'pdfs/checklist_export')
    end

    private

    def name_param
      checklist.name.parameterize.underscore
    end

    def current_time_param
      Time.current.strftime('%Y%m%dT%H%M%SZ')
    end
  end
end
