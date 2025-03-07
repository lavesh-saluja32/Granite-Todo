# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  authentication_token :string
#  email                :string           not null
#  name                 :string           not null
#  password_digest      :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  MAX_NAME_LENGTH = 35
  MIN_PASSWORD_LENGTH = 6
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  MAX_EMAIL_LENGTH = 255
  has_many :comments, dependent: :destroy
  has_many :assigned_tasks, foreign_key: :assigned_user_id, class_name: "Task"
  has_many :created_tasks, foreign_key: :task_owner_id, class_name: "Task"
  has_secure_token :authentication_token
  has_secure_password
  validates :name, presence: true, length: { maximum: MAX_NAME_LENGTH }
  validates :email, presence: true,
    uniqueness: { case_sensitive: false },
    length: { maximum: MAX_EMAIL_LENGTH },
    format: { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: MIN_PASSWORD_LENGTH }, if: -> { password.present? }
  validates :password_confirmation, presence: true, on: :create
  before_save :to_lowercase
  before_destroy :assign_tasks_to_task_owners

  private

    def to_lowercase
      email.downcase!
    end

    def assign_tasks_to_task_owners
      tasks_whose_owner_is_not_current_user = assigned_tasks.where.not(task_owner_id: id)
      tasks_whose_owner_is_not_current_user.find_each do |task|
        task.update(assigned_user_id: task.task_owner_id)
      end
    end
end
