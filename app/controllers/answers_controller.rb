class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  expose :answer
  expose :question, -> { Question.find(params[:question_id]) }
  expose :answers, -> { question.answers }

  def create
    @exposed_answer = question.answers.new(answer_params.merge( user_id: current_user.id))

    if answer.save
      redirect_to question, notice: 'Your answer successfully created.'
    else
      render 'questions/show'
    end
  end

  def update
    if answer.update(answer_params)
      redirect_to answer_path(answer)
    else
      render :edit
    end
  end

  def destroy
    answer.destroy
    redirect_to question_answers_path(answer.question), notice: 'Answer successfully deleted.'
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
