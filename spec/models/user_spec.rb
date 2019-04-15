require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }

  let(:other_user) { create(:user) }
  let(:other_question) { create(:question, user: other_user) }
  let(:other_answer) { create(:answer, question: other_question, user: other_user) }

  it 'User is author of question' do
    expect(user).to be_author(question)
  end
end
