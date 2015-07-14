require 'rails_helper'

feature 'posts -' do
  context 'when no posts have been added' do
    scenario 'display a prompt to add a post' do
      visit '/posts'
      expect(page).to have_content 'no posts yet'
      expect(page).to have_link 'add a post'
    end
  end

  context 'when posts have been added' do
    before do
      user_sign_in

      Post.create(caption: 'sunny Saturday')
    end

    scenario 'display posts' do
      visit '/posts'
      expect(page).to have_content('sunny Saturday')
      expect(page).not_to have_content('No posts yet')
    end
  end

  context 'creating posts' do
    scenario 'prompts user to fill out a form, then displays the new post' do
      user_sign_in

      visit '/posts'
      click_link 'add a post'
      fill_in 'Caption', with: 'sunny Saturday'
      attach_file 'post_image', './public/IMG.jpg'
      click_button 'Create Post'
      expect(page).to have_content 'sunny Saturday'
      expect(current_path).to eq '/'
    end
  end

  context 'viewing posts and their messages' do
    before do
      user_sign_in
    end
    let!(:fresh) { Post.create caption: 'dayday' }

    scenario 'lets a user view an individual post' do
      visit "/posts/#{fresh.id}"
      expect(page).to have_content 'dayday'
      expect(page).to have_content 'sign out'
      expect(page).to have_content 'back to all posts'
    end
  end

  def user_sign_in
    visit('/')
    click_link('sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end
end
