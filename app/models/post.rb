class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :comments

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def update_comments_counter
    update(comments_counter: comments.count)
  end

  def update_likes_counter
    update(likes_counter: likes.count)
  end

  def update_posts_counter
    update(post_counter: posts.count)
  end
end
