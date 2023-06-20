require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'John Doe') }
  let(:post) { Post.create(author: user, title: 'Test Post', text: 'Lorem ipsum') }

  describe 'validations' do
    it 'is valid with an author and a post' do
      like = Like.new(author: user, post: post)
      expect(like).to be_valid
    end

    it 'is invalid without an author' do
      like = Like.new(post: post)
      expect(like).not_to be_valid
      expect(like.errors[:author]).to include("must exist")
    end

    it 'is invalid without a post' do
      like = Like.new(author: user)
      expect(like).not_to be_valid
      expect(like.errors[:post]).to include("must exist")
    end
  end

  describe 'associations' do
    it 'belongs to an author' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq('User')
    end

    it 'belongs to a post' do
      association = described_class.reflect_on_association(:post)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq('Post')
    end
  end

  describe '#update_likes_counter' do
    it 'calls update_likes_counter on the associated post' do
      like = Like.new(author: user, post: post)
      expect(post).to receive(:update_likes_counter)
      like.update_likes_counter
    end
  end
end
