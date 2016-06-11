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
        format.html { redirect_to @answer, notice: 'Answer was successfully created.' }
        format.js {  }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @answer = Answer.find(params[:id])
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
        format.js {  }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
      format.js {  }
    end
  end

  private
    def answer_params
      params.require(:answer).permit(:content, :user_id, :question_id)
    end
end
