require 'rails_helper'

feature 'User can edit own answer', %q{
  In order to correct mistakes
  As an author of answer
  I'd like to be able to edit own answer
} do

    given(:user) { create(:user) }
    given(:question) { create :question, user: user }
    given!(:answer) { create :answer, question: question, user: user }

    given!(:other_user) { create(:user) }
    given!(:other_answer) { create(:answer, question: question, user: other_user) }

  scenario 'Unauthenticated user can not edit answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user', js: true do
    background do
      sign_in user

      visit question_path(question)
    end

    scenario 'edits own answer' do
      within "#answer_#{answer.id}" do
        click_on 'Edit'
        fill_in 'Your answer', with: 'edited answer'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'edits his answer with errors' do
      within "#answer_#{answer.id}" do
        click_on 'Edit'
        fill_in 'Your answer', with: ''
        click_on 'Save'

        expect(page).to have_content answer.body
      end
      expect(page).to have_content "Body can't be blank"
    end

    scenario "tries to edit other user's answer" do
      within "#answer_#{other_answer.id}" do
        expect(page).to_not have_link 'Edit'
      end
    end
  end
end
