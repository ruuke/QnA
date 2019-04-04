require 'rails_helper'

feature 'User can sign out', %q{
  In order to complet the session
  As an authenticated User
  I'd like to be able to sign out
} do
  given(:user) { create(:user) }

  scenario 'Authenticated user tries to sign out' do
    sign_in(user)

    visit destroy_user_session_path

    expect(page).to have_content 'Signed out successfully.'
  end
end
