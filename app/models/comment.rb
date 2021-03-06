class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  delegate :name, :avatar, to: :user, prefix: :user

  scope :parent_comment?, -> {where(parent_id: nil).order created_at: :desc}

  scope :user_comment_course, (lambda do |commentrate|
    where(user_id: commentrate.current_user.id, course_id: commentrate.course_id, parent_id: commentrate.parent_id).last
  end)

  def comment_child?
    Comment.where(parent_id: id).order created_at: :desc
  end

  def block_cmt_child start
    comment_child?.limit(Settings.per_page).offset(start)
  end
end
