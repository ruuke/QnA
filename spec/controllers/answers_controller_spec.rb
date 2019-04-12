require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create :question, user: user }
  let(:answer) { create :answer, question: question, user: user }

  describe 'GET#new' do
    before { login(user) }

    before { get :new, params: { question_id: question} }

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET#edit' do
    before { login(user) }

    before { get :edit, params: { id: answer} }

    it 'render edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST#create' do
    before { login(user) }

    context 'valid attributes' do
      it 'save new answer' do
        count = question.answers.count
        expect { post :create, params: { question_id: question, user: user, answer: attributes_for(:answer)} }.to change(question.answers, :count).by(1)
      end

      it 'redirected to show questions index view' do
        post :create, params: { question_id: question, user: user, answer: attributes_for(:answer)}
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'invalid attributes' do
      it 'does not save answer' do
        count = Answer.count
        expect { post :create, params: { question_id: question, user: user, answer: attributes_for(:answer, :invalid)} }.to_not change(Answer, :count)
      end

      it 're-renders new view' do
        post :create, params: { question_id: question, user: user, answer: attributes_for(:answer, :invalid) }
        expect(response).to render_template 'questions/show'
      end
    end
  end

  describe 'PATCH#update' do
    before { login(user) }

    context 'valid attributes' do
      it 'assigns @answer' do
        patch :update, params: { id: answer, answer: attributes_for(:answer) }
        expect(assigns(:exposed_answer)).to eq answer
      end

      it 'change answer attributes' do
        patch :update, params: { id: answer, answer: { body: 'new body'} }
        answer.reload

        expect(answer.body).to eq 'new body'
      end

      it 'redirected to updated answer' do
        patch :update, params: { id: answer, answer: attributes_for(:answer) }
        expect(response).to redirect_to answer
      end
    end

    context 'invalid attributes' do
      before { patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) } }

      it 'does not change question' do
        answer.reload
        expect(answer.body).to eq "MyAnswerText"
      end

      it 're-render edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login(user) }

    let!(:answer) {create :answer, question: question, user: user }
    let!(:other_user) { create(:user) }
    let!(:other_answer) {create :answer, question: question, user: other_user }

    context 'User tries to' do
      it 'delete own answer' do
        expect { delete :destroy, params: { id: answer }}.to change(Answer, :count).by(-1)
      end

      it 'redirect to index view' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to question_path(answer.question)
      end
    end

    context 'User tries to' do
      it 'delete anothers answer' do
        expect { delete :destroy, params: { id: other_answer }}.to_not change(Answer, :count)
      end

      it 'redirect to index view' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to question_path(answer.question)
      end
    end
  end
end
