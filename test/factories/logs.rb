# frozen_string_literal: true

# == Schema Information
#
# Table name: logs
#
#  id         :integer          not null, primary key
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  task_id    :integer
#
FactoryBot.define do
  factory :log do

  end
end
