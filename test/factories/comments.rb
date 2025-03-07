# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  task_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_comments_on_task_id  (task_id)
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  task_id  (task_id => tasks.id)
#  user_id  (user_id => users.id)
#
# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    user
    task
    content { Faker::Lorem.paragraph }
  end
end
