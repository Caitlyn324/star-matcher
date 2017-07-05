require 'rails_helper'

feature 'Auditions Show' do
  let!(:audition) { FactoryGirl.create(:audition) }

  scenario 'User visits Audition show page directly' do
    visit audition_path(audition)
    expect(page).to have_content audition.show
    expect(page).to have_content audition.theater
    expect(page).to have_content audition.time.strftime("%e %B at %l:%M %p")
    expect(page).to have_content audition.company
    expect(page).to have_content audition.description
    audition.roles.each do |role|
      expect(page).to have_content role
    end
  end
end
