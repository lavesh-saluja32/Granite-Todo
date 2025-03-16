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
require "test_helper"

class UserNotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user_notification = create(:user_notification)
  end

  def test_last_notification_sent_date_must_be_present
    @user_notification.last_notification_sent_date = nil
    assert @user_notification.invalid?
    assert_includes @user_notification.errors.messages[:last_notification_sent_date], I18n.t("errors.messages.blank")
end

  def test_last_notification_sent_date_must_be_parsable
    # The value of date becomes nil if provided with invalid date.
    # https://github.com/rails/rails/issues/29272

    not_parsable_dates = ["12-13-2021", "32-12-2021", "11-00-2022"]
    not_parsable_dates.each do |not_parsable_date|
      @user_notification.last_notification_sent_date = not_parsable_date
      assert_nil @user_notification.last_notification_sent_date
    end
  end

  def test_last_notification_sent_date_cannot_be_in_past
    @user_notification.last_notification_sent_date = Time.zone.yesterday
    assert @user_notification.invalid?
    assert_includes @user_notification.errors.messages[:last_notification_sent_date], I18n.t("date.cant_be_in_past")
  end
end
