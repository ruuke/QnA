require 'rails_helper'

feature 'User can view questions list', %q{
  In order to get answer to my ploblem
  As any User
  I want to be able to view questions list
} do
  given(:user) { create(:user) }

  background do
    visit questions_path

    expect(page).to have_content 'Questions list'
    expect(page).to have_content 'Title'
    expect(page).to have_content 'Body'
  end

  scenario 'Authenticate user can view questions list' do
    sign_in(user)
  end

  scenario 'Unauthenticate user can view questions list' do
  end
end
