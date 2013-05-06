class QuestionsController < ApplicationController
  before_action :auth, only: [:create, :your_questions]

  def index
    @question = Question.new
    @questions = Question.all.unsolved(params[:page] )
  end

  def create
    @question = current_user.questions.build question_params

    if @question.save
      flash[:success] = 'Your question has been posted!'
      redirect_to @question
    else
      @questions = Question.all.unsolved(params[:page])
      render 'index'
    end
  end

  def show
     @question = Question.find(params[:id])
  end

  def your_questions
    @questions = current_user.your_questions(params[:page])
  end

  private
    def question_params
      params.require(:question).permit(:body)
    end
end
