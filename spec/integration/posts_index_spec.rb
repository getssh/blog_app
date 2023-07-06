require 'rails_helper'

RSpec.feature 'Posts Index', type: :feature do
  scenario 'displays user and post information and redirects to post show page' do
    user = User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Bio for John Doe')
    post1 = user.posts.create(title: 'Post 1', text: 'Text for Post 1')
    post2 = user.posts.create(title: 'Post 2', text: 'Text for Post 2')

    visit user_posts_path(user)

    expect(page).to have_content(user.name)
    expect(page).to have_selector("img[src$='#{user.photo}']")
    expect(page).to have_content("Number of Posts: #{user.posts.count}")

    expect(page).to have_content(post1.title)
    expect(page).to have_content(post2.title)
    expect(page).to have_content(post1.text)
    expect(page).to have_content(post2.text)
    expect(page).to have_content("Comments: #{post1.comments_counter}, Likes: #{post1.likes_counter}")
    expect(page).to have_content("Comments: #{post2.comments_counter}, Likes: #{post2.likes_counter}")

    click_link post1.title
    expect(current_path).to eq(user_post_path(user, post1))
  end
end
