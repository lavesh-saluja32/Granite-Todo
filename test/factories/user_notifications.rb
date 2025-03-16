# frozen_string_literal: true

# == Schema Information
#
# Table name: user_notifications
#
#  id                          :integer          not null, primary key
#  last_notification_sent_date :date             not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  user_id                     :integer
#
# Indexes
#
#  index_user_notifications_on_user_id                           (user_id)
#  index_user_preferences_on_user_id_and_notification_sent_date  (user_id,last_notification_sent_date) UNIQUE
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
FactoryBot.define do
  factory :user_notification do
    user
    last_notification_sent_date { Time.zone.today }
  end
end
