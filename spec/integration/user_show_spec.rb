require 'rails_helper'

RSpec.describe 'Posts', type: :feature do
  describe 'show page' do
    let(:user) do
      User.create(name: 'John', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Bio placeholder', post_counter: 0)
    end

    let!(:post1) do
      Post.create(author: user, title: 'First Test', text: 'First post', likes_counter: 0,
                  comments_counter: 0)
    end

    let!(:post2) do
      Post.create(author: user, title: 'Second Test', text: 'Second post', likes_counter: 0,
                  comments_counter: 0)
    end

    let!(:post3) do
      Post.create(author: user, title: 'Third Test', text: 'Third post', likes_counter: 0,
                  comments_counter: 0)
    end

    before { visit user_path(user) }

    it "renders the user picture" do
      expect(page).to have_css("img[src='#{user.photo}']")
    end

    it "renders the user username" do
      expect(page).to have_content(user.name)
    end

    it 'renders the number of posts the user has written' do
      expect(page).to have_content(user.post_counter)
    end
  end
end
