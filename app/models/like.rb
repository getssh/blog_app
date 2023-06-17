class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def update_likes_counter
    post.update_likes_counter
  end
end
