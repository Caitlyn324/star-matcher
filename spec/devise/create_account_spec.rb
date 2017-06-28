require 'rails_helper'

feature 'user signs up' do
  scenario 'specifying valid and require information' do
    visit root_path
    click_link 'Create Account'
    fill_in 'Name', with: 'John Smith'
    fill_in 'Email', with: 'Jerry.Sanchez@gmail.com'
    fill_in 'Password', with: 'Launch'
    fill_in 'Password confirmation', with: 'Launch'
    fill_in 'Phone Number', with: '(215)345-5176'
    click_button 'Sign up'
    user = User.first
    user.confirm
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: 'Jerry.Sanchez@gmail.com'
    fill_in 'Password', with: 'Launch'
    click_button 'Log in'
    expect(user.confirmation_token).to_not be_nil
    expect(page).to have_content("Signed in successfully")
  end

  scenario "required information isn't supplied" do
    visit root_path
    click_link 'Create Account'
    click_button 'Sign up'
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Phone number can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect(page).to_not have_content("Sign Out")
  end

  scenario 'phone number is incorrectly formatted' do
    visit root_path
    click_link 'Create Account'
    fill_in 'Phone Number', with: '2'

    click_button 'Sign up'
    expect(page).to have_content("Phone number isn't valid")
  end

  scenario "phone number isn't unique" do
    visit root_path
    click_link 'Create Account'
    fill_in 'Name', with: 'John Smith'
    fill_in 'Email', with: 'Jerry.Sanchez@gmail.com'
    fill_in 'Password', with: 'Launch'
    fill_in 'Password confirmation', with: 'Launch'
    fill_in 'Phone Number', with: '2679871412'
    click_button 'Sign up'

    click_link 'Create Account'
    fill_in 'Phone Number', with: '2679871412'

    click_button 'Sign up'
    expect(page).to have_content("Phone number has already been taken")
  end

  scenario 'phone number is incorrectly formatted' do
    visit root_path
    click_link 'Create Account'
    fill_in 'Phone Number', with: '2'

    click_button 'Sign up'
    expect(page).to have_content("Phone number isn't valid")
  end

  scenario "email isn't unique" do
    visit root_path
    click_link 'Create Account'
    fill_in 'Name', with: 'John Smith'
    fill_in 'Email', with: 'Jerry.Sanchez@gmail.com'
    fill_in 'Password', with: 'Launch'
    fill_in 'Password confirmation', with: 'Launch'
    fill_in 'Phone Number', with: '2679871412'
    click_button 'Sign up'

    click_link 'Create Account'
    fill_in 'Email', with: 'Jerry.Sanchez@gmail.com'

    click_button 'Sign up'
    expect(page).to have_content("Email has already been taken")
  end



  scenario 'email is incorrectly formatted' do
    visit root_path
    click_link 'Create Account'
    fill_in 'Email', with: 'chris@gmail'

    click_button 'Sign up'
    expect(page).to have_content("Email isn't valid!")
  end

  scenario 'email is incorrectly formatted' do
    visit root_path
    click_link 'Create Account'
    fill_in 'Name', with: 'chris'

    click_button 'Sign up'
    expect(page).to have_content("Name must be a first name and last name")
  end

  scenario 'Password confirmation does not match password' do
    visit root_path
    click_link 'Create Account'
    fill_in 'Password', with: 'Launch'
    fill_in 'Password confirmation', with: 'Lanch'
    click_button 'Sign up'
    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content("Sign Out")
  end
end
