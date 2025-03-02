# frozen_string_literal: true

json.tasks @tasks do |task|
  json.extract! task, :id, :title
  json.assigned_user do
    json.extract! task.assigned_user, :id, :name if task.assigned_user.present?
  end

end
