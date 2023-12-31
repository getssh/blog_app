class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  validates :text, presence: true

  after_create :update_comments_counter

  def update_comments_counter
    post.update_comments_counter
  end
end
