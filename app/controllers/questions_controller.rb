class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  expose :questions, -> { Question.all }
  expose :question

  def create
    @exposed_question = current_user.questions.new(question_params)

    if question.save
      redirect_to question_path(question), notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def update
    if question.update(question_params)
      redirect_to question_path(question)
    else
      render :edit
    end
  end

  def destroy
    question.destroy
    redirect_to questions_path, notice: 'Question successfully deleted.'
  end


  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
