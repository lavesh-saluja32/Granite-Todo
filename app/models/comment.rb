# frozen_string_literal: true

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
class Comment < ApplicationRecord
  MAX_CONTENT_LENGTH = 511

  belongs_to :user # Each comment belongs to a single user
  belongs_to :task # Each comment belongs to a single task

  validates :content, presence: true, length: { maximum: MAX_CONTENT_LENGTH }
end
