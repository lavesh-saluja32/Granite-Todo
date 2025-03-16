# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id               :integer          not null, primary key
#  comments_count   :integer
#  progress         :string           default("pending"), not null
#  slug             :string           not null
#  status           :string           default("unstarred"), not null
#  title            :text             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  assigned_user_id :integer
#  task_owner_id    :integer
#
# Indexes
#
#  index_tasks_on_slug  (slug) UNIQUE
#
# Foreign Keys
#
#  assigned_user_id  (assigned_user_id => users.id)
#  task_owner_id     (task_owner_id => users.id) ON DELETE => cascade
#
class Task < ApplicationRecord
  MAX_TITLE_LENGTH = 125
  VALID_TITLE_REGEX = /\A.*[a-zA-Z0-9].*\z/i
  RESTRICTED_ATTRIBUTES = %i[title task_owner_id assigned_user_id]

  enum :progress, { pending: "pending", completed: "completed" }, default: :pending
  enum :status, { unstarred: "unstarred", starred: "starred" }, default: :unstarred
  has_many :comments, dependent: :destroy
  belongs_to :assigned_user, foreign_key: "assigned_user_id", class_name: "User"
  belongs_to :task_owner, foreign_key: "task_owner_id", class_name: "User"
  validates :title,
    presence: true,
    length: { maximum: MAX_TITLE_LENGTH },
    format: { with: VALID_TITLE_REGEX }
  validates :slug, uniqueness: true
  validate :slug_not_changed

  before_create :set_slug
  after_create :log_task_details

  def self.of_status(progress)
    if progress == :pending
      pending.in_order_of(:status, %w(starred unstarred)).order("updated_at DESC")
    else
      completed.in_order_of(:status, %w(starred unstarred)).order("updated_at DESC")
    end
  end

  def log_task_details
    TaskLoggerJob.perform_async(self.id)
  end

  private

    def set_slug
      title_slug = title.parameterize
      regex_pattern = "slug #{Constants::DB_REGEX_OPERATOR} ?"
      latest_task_slug = Task.where(
        regex_pattern,
        "^#{title_slug}$|^#{title_slug}-[0-9]+$"
      ).order("LENGTH(slug) DESC", slug: :desc).first&.slug
      slug_count = 0
      if latest_task_slug.present?
        slug_count = latest_task_slug.split("-").last.to_i
        only_one_slug_exists = slug_count == 0
        slug_count = 1 if only_one_slug_exists
      end
      slug_candidate = slug_count.positive? ? "#{title_slug}-#{slug_count + 1}" : title_slug
      self.slug = slug_candidate
    end

    def slug_not_changed
      if will_save_change_to_slug? && self.persisted?
        errors.add(:slug, I18n.t("task.slug.immutable"))
      end
    end
end
