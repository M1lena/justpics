require 'rails_helper'

feature "User can sign in and out" do
  context "when on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('sign in')
      expect(page).to have_link('sign up')
    end

    it "should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('sign out')
    end
  end

  context "user signed in on the homepage" do
    before do
      visit('/')
      click_link('sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end

    it "should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('sign out')
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('sign in')
      expect(page).not_to have_link('sign up')
    end
  end
end