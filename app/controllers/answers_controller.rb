class AnswersController < ApplicationController
  before_action :authenticate_user!

  expose :answer
  expose :question, -> { Question.find(params[:question_id]) }

  def create
    @exposed_answer = question.answers.create(answer_params.merge( user_id: current_user.id))
  end

  def update
    answer.update(answer_params) if current_user.author?(answer)
    @question = answer.question
  end

  def destroy
    if current_user.author?(answer)
      answer.destroy
      redirect_to question_path(answer.question), notice: 'Answer successfully deleted.'
    else
      redirect_to question_path(answer.question), notice: 'You have no rigths to delete this answer.'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
