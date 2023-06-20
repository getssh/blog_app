require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'John Doe') }

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:likes) }
    it { should have_many(:comments) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe '#recent_comments' do
    let(:post) { Post.create(author: user, title: 'Test Post') }

    it 'returns the most recent comments of the post' do
      comment1 = post.comments.create(author: user, text: 'First comment')
      comment2 = post.comments.create(author: user, text: 'Second comment')
      comment3 = post.comments.create(author: user, text: 'Third comment')

      expect(post.recent_comments).to eq([comment3, comment2, comment1])
    end

    it 'limits the number of recent comments to 5' do
      10.times { |i| post.comments.create(author: user, text: "Comment #{i + 1}") }

      expect(post.recent_comments.count).to eq(5)
    end
  end

  describe '#update_comments_counter' do
    let(:post) { Post.create(author: user, title: 'Test Post') }

    it 'updates the comments_counter attribute of the post' do
      post.comments.create(author: user, text: 'First comment')
      post.comments.create(author: user, text: 'Second comment')

      post.update_comments_counter

      expect(post.comments_counter).to eq(2)
    end
  end

  describe '#update_likes_counter' do
    let(:post) { Post.create(author: user, title: 'Test Post') }

    it 'updates the likes_counter attribute of the post' do
      post.likes.create(author: user)

      post.update_likes_counter

      expect(post.likes_counter).to eq(1)
    end
  end

  describe '#update_posts_counter' do
    let(:user) { User.create(name: 'John Doe') }

    it 'updates the post_counter attribute of the user' do
      user.posts.create(title: 'First Post')
      user.posts.create(title: 'Second Post')

      user.update_posts_counter

      expect(user.post_counter).to eq(2)
    end
  end
end
