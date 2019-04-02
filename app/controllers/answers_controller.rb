class AnswersController < ApplicationController
  before_action :set_question, only: %i[index create]
  before_action :set_answer, only: %i[show edit update destroy]

  def index
    @answers = @question.answers
  end

  def new
    @answer = Answer.new
  end

  def create
    @answer = @question.answers.new(answer_params)

    if @answer.save
      redirect_to @answer
    else
      render :new
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to @answer
    else
      render :edit
    end
  end

  def show

  end

  def edit

  end

  def destroy
    @answer.destroy
    redirect_to question_answers_path(@answer.question)
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
