# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user_panel/checklist_mailer

module UserPanel
  class ChecklistMailerPreview < ActionMailer::Preview
    def checklist_export
      checklist = Checklist.last
      user = checklist.user

      ChecklistMailer.with(checklist: checklist, user: user).checklist_export
    end
  end
end
