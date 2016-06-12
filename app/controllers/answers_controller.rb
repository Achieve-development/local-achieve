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
    @answer = current_user.answers.find(params[:id])
  end


  def create
    @answer = Answer.new(answer_params)
    respond_to do |format|
      if @answer.save
        @answers = @answer.question.answers
        @answer = Answer.new
        format.html { redirect_to question_path(@answer.question) }
        format.js { render :create }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @answer = current_user.answers.find(params[:id])
    if @answer.update(answer_params)
      redirect_to question_path(@answer.question)
    else
      format.html { render :edit }
    end
  end

  def destroy
    @answer = current_user.answers.find(params[:id])
    @answer.destroy
    @answers = @answer.question.answers
    respond_to do |format|
      format.html { redirect_to question_path(@question.id) }
      format.js { render :index }
    end
  end

  private
    def answer_params
      params.require(:answer).permit(:content, :user_id, :question_id)
    end
end
