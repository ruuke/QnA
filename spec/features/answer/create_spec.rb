require 'rails_helper'

feature 'User can create answer', %q{
  In order to give an answer to a question
  As an authenticated User
  I'd like to be able to give answer
} do

  given(:user) { create(:user) }

  given(:question) { create(:question) }

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit question_path(question)
    end

    scenario 'gives an asnwer to a question' do
      fill_in 'Body', with: 'answer body'
      click_on 'Reply'

      expect(page).to have_content 'Your answer successfully created.'
      expect(page).to have_content 'answer body'
    end

    scenario 'gives an asnwer with errors' do
      click_on 'Reply'

      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario 'Unauthenticated user tries to give an answer' do
    visit question_path(question)

    click_on 'Reply'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
  # given!(:questions) { create_list(:question, 3) }
      # visit questions_path
      # find("a[href='/questions/#{questions.last.id}']").click
      # save_and_open_page
