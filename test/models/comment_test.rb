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
require "test_helper"

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @comment = build(:comment)
  end

  def test_comment_should_be_invalid_without_content
    @comment.content = ""
    assert @comment.invalid?
end

  def test_comment_content_should_not_exceed_maximum_length
    @comment.content = "a" * (Comment::MAX_CONTENT_LENGTH + 1)
    assert @comment.invalid?
  end

  def test_valid_comment_should_be_saved
    assert_difference "Comment.count" do
      @comment.save
    end
  end

  def test_comment_should_not_be_valid_without_user
    @comment.user = nil
    assert @comment.invalid?
  end

  def test_comment_should_not_be_valid_without_task
    @comment.task = nil
    assert @comment.invalid?
  end
end
