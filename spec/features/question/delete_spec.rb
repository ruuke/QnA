require 'rails_helper'

feature 'User can delete own question', %q{
  In order to delete question
  As an authenticated User
  I'd like to be able to delete own question
} do
    given(:user) { create(:user) }
    given(:question) { create :question, user: user }
    given(:other_user) { create(:user) }

  scenario 'Question owner tries to delete own question' do
    sign_in(user)
    visit question_path(question)

    expect(page).to have_content "#{question.title}"

    click_on 'Delete'

    expect(page).to have_content 'Question successfully deleted.'
    expect(page).to_not have_content "#{question.title}"
  end

  scenario 'Other user tries to delete question' do
    sign_in(other_user)
    visit question_path(question)

    expect(page).to have_content "#{question.title}"
    expect(page).to_not have_link 'Delete'
  end
end
