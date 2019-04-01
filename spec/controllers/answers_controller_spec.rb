require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create :question }
  let(:answer) { create :answer, question: question}
  before { get :index, params: { question_id: question } }

  describe 'GET#index' do
    let(:answers) { create_list :answer, 3, question: question}

    before { get :index, params: { question_id: question } }

    it 'assigns @answers' do
      expect(assigns(:answers)).to match_array(answers)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET#show' do
    before { get :show, params: { id: answer}}

    it 'assigns @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET#new' do
    before { get :new, params: { question_id: question} }

    it 'assigns @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET#edit' do
    before { get :edit, params: { id: answer} }

    it 'assigns @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'render edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST#create' do
    context 'valid attributes' do
      it 'save new answer' do
        count = Answer.count
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer)} }.to change(Answer, :count).by(1)
      end

      it 'redirected to show view' do
        post :create, params: { question_id: question, answer: attributes_for(:answer)}
        expect(response).to redirect_to assigns(:answer)
      end
    end

    context 'invalid attributes' do
      it 'does not save answer' do
        count = Answer.count
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid)} }.to_not change(Answer, :count)
      end

      it 're-renders new view' do
        post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH#update' do
    context 'valid attributes' do
      it 'assigns @answer' do
        patch :update, params: { id: answer, answer: attributes_for(:answer) }
        expect(assigns(:answer)).to eq answer
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
        expect(answer.body).to eq "MyText"
      end

      it 're-render edit view' do
        expect(response).to render_template :edit
      end
    end

  describe 'DELETE #destroy' do
    let!(:answer) {create :answer, question: question}
    it 'delete the answer' do
      expect { delete :destroy, params: { id: answer }}.to change(Answer, :count).by(-1)
    end

    it 'redirect to index view' do
      delete :destroy, params: { id: answer }
      expect(response).to redirect_to question_answers_path(answer.question)
    end
  end


  end


end
