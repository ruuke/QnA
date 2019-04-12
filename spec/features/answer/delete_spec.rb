require 'rails_helper'

feature 'User can delete own answer', %q{
  In order to delete answer
  As an authenticated User
  I'd like to be able to delete own answer
} do
    given(:user) { create(:user) }
    given(:question) { create :question, user: user }
    given!(:answer) { create :answer, question: question, user: user }
    given(:other_user) { create(:user) }

  scenario 'Answer owner tries to delete own answer' do
    sign_in(user)
    visit question_path(question)

    expect(page).to have_content "#{answer.body}"

    click_on 'Delete answer'

    expect(page).to have_content 'Answer successfully deleted.'
    expect(page).to_not have_content "#{answer.body}"
  end

  scenario 'Other user tries to delete answer' do
    sign_in(other_user)
    visit question_path(question)

    expect(page).to have_content "#{answer.body}"
    expect(page).to_not have_link 'Delete answer'
  end
end
