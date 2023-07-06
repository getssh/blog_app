require 'rails_helper'

RSpec.feature 'Post Show', type: :feature do
  scenario 'displays post information, comments, and redirects to comment show page' do
    user = User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Bio for John Doe')
    post = user.posts.create(title: 'Post 1', text: 'Text for Post 1', likes_counter: 0, comments_counter: 0)
    comment1 = post.comments.create(author: user, text: 'Comment 1')
    comment2 = post.comments.create(author: user, text: 'Comment 2')

    visit user_post_path(user, post)

    expect(page).to have_content(post.title)
    expect(page).to have_content(post.text)
    expect(page).to have_content("Comments: #{post.comments.count}")
    expect(page).to have_content(comment1.text)
    expect(page).to have_content(comment2.text)
    expect(page).to have_content('Add a Comment')

  end
end