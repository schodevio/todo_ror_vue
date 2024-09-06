# frozen_string_literal: true

module UserPanel
  class ChecklistsController < BaseController
    respond_to :html, :json

    def index
      @checklists = current_user.checklists.order(created_at: :desc)

      respond_with @checklists
    end

    def show
      checklist
    end

    def create
      @checklist = current_user.checklists.create(checklist_params)

      respond_with @checklist
    end

    def update; end

    def destroy; end

    private

    def checklist
      @checklist ||= current_user.checklists.find(params[:id])
    end

    def checklist_params
      params.require(:checklist).permit(:name)
    end
  end
end
