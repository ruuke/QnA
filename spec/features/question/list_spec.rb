require 'rails_helper'

feature 'User can view questions list', %q{
  In order to get answer to my ploblem
  As any User
  I want to be able to view questions list
} do
  given(:user) { create(:user) }
  given!(:question1) { create(:question, user: user) }
  given!(:question2) { create(:question, user: user) }

  background do
    visit questions_path
  end

  scenario 'Authenticate user can view questions list' do
    sign_in(user)


    expect(page).to have_content "#{question1.title}"
    expect(page).to have_content "#{question2.title}"
    expect(page).to have_content "#{question1.body}"
    expect(page).to have_content "#{question2.body}"
  end

  scenario 'Unauthenticate user can view questions list' do

    expect(page).to have_content "#{question1.title}"
    expect(page).to have_content "#{question2.title}"
    expect(page).to have_content "#{question1.body}"
    expect(page).to have_content "#{question2.body}"
  end
end
