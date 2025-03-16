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
  # test "the truth" do
  #   assert true
  # end
end
