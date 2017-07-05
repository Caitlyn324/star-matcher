require 'rails_helper'

feature 'actor signs in' do
  let!(:actor) { FactoryGirl.create(:actor, email: 'Emailemailemail@email.com', password: 'maybethistime') }

  scenario 'existing actor specifies a valid email and password' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: actor.email
    fill_in 'Password', with: actor.password
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content('Sign Out')
  end

  scenario 'an invalid email and password are supplied' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: 'actor'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content('Invalid Email or password.')
    expect(page).to_not have_content('Signed in successfully.')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'right email with wrong password is supplied' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: actor.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to_not have_content('Signed in successfully.')
    expect(page).to_not have_content('Sign Out')
    expect(page).to have_content('Invalid Email or password.')
  end

  scenario 'wrong email with right password is supplied' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: 'emale'
    fill_in 'Password', with: actor.password
    click_button 'Log in'
    expect(page).to have_content('Invalid Email or password.')
    expect(page).to_not have_content('Signed in successfully.')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'an already authenticated actor cannot re-sign in' do
    visit new_actor_session_path
    fill_in 'Email', with: actor.email
    fill_in 'Password', with: actor.password
    click_button 'Log in'
    expect(page).to_not have_content('Sign In')
    expect(page).to have_content('Sign Out')
  end
end
