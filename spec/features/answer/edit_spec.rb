require 'rails_helper'

feature 'User can edit own answer', %q{
  In order to correct mistakes
  As an author of answer
  I'd like to be able to edit own answer
} do

    given(:user) { create(:user) }
    given(:question) { create :question, user: user }
    given!(:answer) { create :answer, question: question, user: user }

  scenario 'Unauthenticated user can not edit answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user', js: true do
    scenario 'edits own answer' do
      sign_in user

      visit question_path(question)
      click_on 'Edit'

      within '.answers' do
        fill_in 'Your answer', with: 'edited answer'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end


    scenario 'edits own answer with errors'
    scenario "tries to edit other users's question"
  end
end
