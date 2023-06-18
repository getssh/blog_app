require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(name: 'John Doe') }

  it 'is valid with a name' do
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user.name = nil
    expect(user).to be_invalid
    expect(user.errors[:name]).to include("can't be blank")
  end

  it 'validates the post_counter to be a non-negative integer' do
    user.post_counter = 10
    expect(user).to be_valid

    user.post_counter = -5
    expect(user).to be_invalid
    expect(user.errors[:post_counter]).to include('must be greater than or equal to 0')

    user.post_counter = 5.5
    expect(user).to be_invalid
    expect(user.errors[:post_counter]).to include('must be an integer')
  end

  it 'returns the three most recent posts' do
    user.save

    post1 = Post.create(title: 'Post 1', author: user, created_at: 1.hour.ago)
    post2 = Post.create(title: 'Post 2', author: user, created_at: 30.minutes.ago)
    post3 = Post.create(title: 'Post 3', author: user, created_at: 1.minute.ago)
    post4 = Post.create(title: 'Post 4', author: user, created_at: 1.day.ago)

    expect(user.recent_posts).to eq([post3, post2, post1])
  end
end
