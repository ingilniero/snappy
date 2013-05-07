class QuestionsController < ApplicationController
  before_action :auth, only: [:create, :your_questions, :edit, :update]

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
     @answer = Answer.new
  end

  def your_questions
    @questions = current_user.your_questions(params[:page])
  end

  def edit
    @question = current_user.questions.find(params[:id])
  end

  def update
    @question = current_user.questions.find(params[:id])

    if @question.update_attributes(question_params)
      flash[:success] = 'Your question has been updated!'
      redirect_to @question
    else
      render 'edit'
    end
  end

  def search
    @questions = Question.search(params)
  end

  private
    def question_params
      params.require(:question).permit(:body, :solved)
    end
end
