require 'rails_helper'

feature 'actor signs out' do
  let!(:actor) { FactoryGirl.create(:actor, email: 'dfsjlfsdjlfds@gmail.com') }

  scenario 'signed-in actor successfully signs out' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: actor.email
    fill_in 'Password', with: actor.password
    click_button 'Log in'
    click_link 'Sign Out'

    expect(page).to have_content('Signed out successfully')
    expect(page).to have_content('Create Account')
  end

  scenario 'unauthenticated actor cannot succesfully sign out' do
    visit root_path

    expect(page).to_not have_content('Sign Out')
  end
end
