# frozen_string_literal: true

module UserPanel
  module Checklists
    class TasksController < BaseController
      respond_to :json

      def index
        @tasks = checklist.tasks

        respond_with @tasks
      end

      def create
        @task = checklist.tasks.create(task_params)

        respond_with @task
      end

      def update
        task.update(task_params)

        respond_with task
      end

      def destroy
        task.destroy

        head :no_content
      end

      private

      def checklist
        @checklist ||= current_user.checklists.find(params[:checklist_id])
      end

      def task
        @task ||= checklist.tasks.find(params[:id])
      end

      def task_params
        params.require(:task).permit(:name, :description, :completed, :position)
      end
    end
  end
end
