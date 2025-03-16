# frozen_string_literal: true

# == Schema Information
#
# Table name: preferences
#
#  id                         :integer          not null, primary key
#  notification_delivery_hour :integer
#  should_receive_email       :boolean          default(TRUE), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  user_id                    :integer
#
# Indexes
#
#  index_preferences_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Preference < ApplicationRecord
  belongs_to :user

  validates :notification_delivery_hour, presence: true,
    numericality: { only_integer: true },
    inclusion: {
      in: 0..23,
      message: "value should be between 0 and 23"
    }
end
