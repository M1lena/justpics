require 'rails_helper'

feature 'posts' do
  context 'no posts have been added' do
    scenario 'should display a prompt to add a post' do
      visit '/posts'
      expect(page).to have_content 'no posts yet'
      expect(page).to have_link 'add a post'
    end
  end

  context 'posts have been added' do
    before do
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
      visit '/posts'
      click_link 'add a post'
      fill_in 'Caption', with: 'sunny Saturday'
      click_button 'Create Post'
      expect(page).to have_content 'sunny Saturday'
      expect(current_path).to eq '/'
    end
  end
end
