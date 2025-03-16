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
require "test_helper"

class PreferenceTest < ActiveSupport::TestCase
  def setup
    user = create(:user)
    @preference = user.preference
  end

  def test_notification_delivery_hour_must_be_present_and_valid
    @preference.notification_delivery_hour = nil
    assert @preference.invalid?
    assert_includes @preference.errors.messages[:notification_delivery_hour], I18n.t("errors.messages.blank")
end

  def test_notification_delivery_hour_should_be_in_range
    invalid_hours = [-10, -0.5, 10.5, 23.5, 24]

    invalid_hours.each do |hour|
      @preference.notification_delivery_hour = hour
      assert @preference.invalid?
    end
  end
end
