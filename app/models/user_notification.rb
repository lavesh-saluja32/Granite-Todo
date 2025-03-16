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
class UserNotification < ApplicationRecord
  belongs_to :user

  validates :last_notification_sent_date, presence: true
  validate :last_notification_sent_date_is_valid_date
  validate :last_notification_sent_date_cannot_be_in_the_past

  private

    def last_notification_sent_date_is_valid_date
      if last_notification_sent_date.present?
        Date.parse(last_notification_sent_date.to_s)
      end
    rescue ArgumentError
      errors.add(:last_notification_sent_date, "must be a valid date")
    end

    def last_notification_sent_date_cannot_be_in_the_past
      if last_notification_sent_date.present? &&
          last_notification_sent_date < Time.zone.today
        errors.add(:last_notification_sent_date, "can't be in the past")
      end
    end
end
