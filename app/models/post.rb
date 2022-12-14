class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'authorId'
  has_many :comments, dependent: :destroy, foreign_key: 'postId'
  has_many :likes, dependent: :destroy, foreign_key: 'postId'

  validates :title, presence: true, length: { minimum: 3, maximum: 250 }
  validates :text, presence: true, length: { minimum: 3, maximum: 5000 }
  validates :commentsCounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likesCounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_post_counter
  after_destroy :update_post_counter

  def comments
    Comment.where(postId: self).order(created_at: :desc)
  end

  def five_most_recent_comments
    Comment.where(postId: self).order(created_at: :desc).limit(5)
  end

  private

  def update_post_counter
    author.update(postCounter: author.posts.count)
  end
end
