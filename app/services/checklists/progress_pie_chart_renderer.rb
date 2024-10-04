# frozen_string_literal: true

module Checklists
  class ProgressPieChartRenderer
    include Callable

    attr_reader :checklist, :size

    delegate :tasks, to: :checklist

    def initialize(checklist, size: 480)
      @checklist = checklist
      @size = size
    end

    def call
      g = Gruff::Pie.new(size)

      g.title = "#{checklist.name} - Progress"
      g.theme = Gruff::Themes::PASTEL

      g.data(:ToDo, tasks.where(completed: false).count)
      g.data(:Completed, tasks.where(completed: true).count)

      g.to_image
    end
  end
end
