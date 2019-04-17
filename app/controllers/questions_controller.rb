class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  expose :questions, -> { Question.all }
  expose :question
  expose :answer, -> { Answer.new }

  def create
    @exposed_question = current_user.questions.new(question_params)

    if question.save
      redirect_to question_path(question), notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def update
    question.update(question_params) if current_user.author?(question)
  end

  def destroy
    if current_user.author?(question)
      question.destroy
      redirect_to questions_path, notice: 'Question successfully deleted.'
    else
      redirect_to questions_path, notice: 'You have no rigths to delete this question.'
    end
  end


  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
