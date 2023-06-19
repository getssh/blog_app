require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'John Doe') }
  let(:post) { Post.create(title: 'Test Post', author: user) }

  describe 'validations' do
    it 'is valid with text, author, and post' do
      comment = Comment.new(text: 'Test Comment', author: user, post: post)
      expect(comment).to be_valid
    end

    it 'is invalid without text' do
      comment = Comment.new(author: user, post: post)
      expect(comment).not_to be_valid
      expect(comment.errors[:text]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'belongs to an author' do
      association = Comment.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq('User')
    end

    it 'belongs to a post' do
      association = Comment.reflect_on_association(:post)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe '#update_comments_counter' do
    it 'calls update_comments_counter on the associated post' do
      comment = Comment.new(text: 'Test Comment', author: user, post: post)
      expect(post).to receive(:update_comments_counter)
      comment.update_comments_counter
    end
  end
end
