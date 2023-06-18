require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'John Doe') }
  let(:post) { Post.create(title: 'Test Post', author: user) }

  describe 'validations' do
    it 'is valid with an author and post' do
      like = Like.new(author: user, post: post)
      expect(like).to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to an author' do
      association = Like.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq('User')
    end

    it 'belongs to a post' do
      association = Like.reflect_on_association(:post)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
