# frozen_string_literal: true

module UserPanel
  class ChecklistsController < BaseController
    respond_to :html, :json

    def index
      @checklists = current_user.checklists.order(created_at: :desc).with_attached_thumbnail

      respond_with @checklists
    end

    def show
      @tasks = checklist.tasks

      respond_with checklist
    end

    def create
      @checklist = current_user.checklists.create(checklist_params)

      respond_with @checklist
    end

    def update
      checklist.update(checklist_params)

      respond_with checklist
    end

    def destroy
      checklist.destroy

      head :no_content
    end

    def export
      presenter = ::Checklists::ExportPresenter.new(checklist, user: current_user)

      respond_to do |format|
        format.pdf do
          send_data(presenter.as_pdf, filename: presenter.filename, disposition: 'inline')
        end
      end
    end

    def send_email
      send_email_form.call

      respond_with send_email_form, location: nil, status: :no_content
    end

    private

    def checklist
      @checklist ||= current_user.checklists.find(params[:id])
    end

    def checklist_params
      params.require(:checklist).permit(:name, :thumbnail)
    end

    def send_email_form
      @send_email_form ||= Checklists::SendEmailForm.new(checklist, params: send_email_params)
    end

    def send_email_params
      params.require(:checklist).permit(:receiver_email).merge(user: current_user)
    end
  end
end
