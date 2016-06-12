class AnswersController < ApplicationController
  before_action :authenticate_user!

  def index
    @answers = Answer.all
  end

  def show
    @answer = Answer.find(params[:id])
  end


  def new
    @answer = Answer.new
  end


  def edit
    @answer = Answer.find(params[:id])
  end

  def create
    @answer = Answer.new(answer_params)

    respond_to do |format|
      if @answer.save
        @question = @answer.question
        format.html { redirect_to question_path(@question.id) }
        format.js
      else
        format.html { render :new }
      end
    end
  end

  def update
    @answer = Answer.find(params[:id])
    @question = @answer.question
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to redirect_to question_path(@question.id) }
        format.js
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @question = @answer.question
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to redirect_to question_path(@question.id) }
      format.js {  }
    end
  end

  private
    def answer_params
      params.require(:answer).permit(:content, :user_id, :question_id)
    end
end
