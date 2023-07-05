require 'rails_helper'
RSpec.feature 'Users Index', type: :feature do
  scenario 'displays user information and redirects to user show page' do
    user1 = User.create(name: 'John Doe', photo: '
https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Bio for John Doe')
    user2 = User.create(name: 'Jane Smith', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Bio for Jane Smith')
    visit users_path
    expect(page).to have_content(user1.name)
    expect(page).to have_content(user2.name)
    expect(page).to have_selector("img[src$='#{user1.photo}']")
    expect(page).to have_selector("img[src$='#{user2.photo}']")
  end
end