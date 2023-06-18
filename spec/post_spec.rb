require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:author) { User.create(name: 'John Doe') }
  let(:post) { Post.create(title: 'Test Post', author: author) }

  it 'validates presence of title' do
    expect(post).to validate_presence_of(:title)
  end

  it 'validates maximum length of title' do
    expect(post).to validate_length_of(:title).is_at_most(250)
  end

  it 'validates comments_counter to be a non-negative integer' do
    expect(post).to validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0)
  end

  it 'validates likes_counter to be a non-negative integer' do
    expect(post).to validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0)
  end

  it 'belongs to an author' do
    expect(post).to belong_to(:author).class_name('User')
  end

  it 'has many likes' do
    expect(post.likes).to be_an(ActiveRecord::Associations::CollectionProxy)
  end

  it 'has many comments' do
    expect(post.comments).to be_an(ActiveRecord::Associations::CollectionProxy)
  end

  it 'returns the author of the post' do
    expect(post.author).to eq(author)
  end
end
