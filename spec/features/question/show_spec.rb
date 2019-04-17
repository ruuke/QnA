require 'rails_helper'

feature 'User can view question and answers to it', %q{
  In order to get answer from a community
  As any user
  I'd like to be able to view question and answers to it
} do
  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer1) { create(:answer, body: 'a1', question: question, user: user) }
  given!(:answer2) { create(:answer, body: 'a2', question: question, user: user) }


  scenario 'Authenticate user review question and answers to it' do
    sign_in(user)

    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body
    expect(page).to have_content answer1.body
    expect(page).to have_content answer2.body
  end

  scenario 'Unauthenticate user review question and answers to it' do
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body
    expect(page).to have_content answer1.body
    expect(page).to have_content answer2.body
  end
end
