class SubmitRequestsController < ApplicationController
  before_action :set_submit_request, only: [:show, :edit, :update, :destroy]
  before_action :submit_params, only: [:approve, :unapprove]

  def index
    @submit_requests = SubmitRequest.where(user_id: current_user.id).order(updated_at: :desc)
  end

  def new
    @users = current_user.friend #相互フォローユーザ
    @tasks = current_user.tasks.where(done: false) #未完了のタスク
    @user  = current_user
    @submit_request = current_user.submit_requests.build(status: 1) #statusを１にして新規依頼作成
  end

  def create
    @submit_request = SubmitRequest.new(submit_request_params)
    if @submit_request.save
      @submit_request.update(status: 1)
      redirect_to user_submit_requests_path(user_id: current_user.id), notice: '依頼を送信しました。'
    else
      render 'new'
    end
  end

  def show
  end

  def edit
    @users = current_user.friend #相互フォローユーザー
    @tasks = current_user.tasks.where(done: false) #自分が作成した未完了タスク
  end

  def update
    if @submit_request.update(submit_request_params)
      @submit_request.task.update(charge_id: submit_request_params[:user_id])
      redirect_to user_submit_requests_path(user_id: current_user.id), notice: '依頼を更新しました。'
    else
      render 'edit'
    end
  end

  def destroy
  end

  def approve
    @submit_request.update(status: 2)
    @submit_request.task.update(status: 2)
    @submit_requests = SubmitRequest.where(charge_id: current_user.id).order(updated_at: :desc)
    respond_to do |format|
      format.js { render 'reaction_inbox' }
    end
  end

  def unapprove
    @submit_request.update(status: 9)
    @submit_request.task.update(status: 9, charge_id: @submit_request.user_id)
    @submit_requests = SubmitRequest.where(charge_id: current_user.id).order(updated_at: :desc)
    respond_to do |format|
      format.js { render :reaction_inbox }
    end
  end

  def reject
    @submit_request.update(status: 8)
    @submit_request.task.update(status: 8, charge_id: current_user.id)
    @submit_requests = SubmitRequest.where(charge_id: current_user.id).order(updated_at: :desc)
    respond_to do |format|
      format.js { render :reaction_index }
    end
  end

  def inbox
    @submit_requests = SubmitRequest.where(charge_id: current_user.id).order(updated_at: :desc)
  end

  private
    def set_submit_request
      @submit_request = SubmitRequest.find(params[:id])
    end

    def submit_params
      @submit_request = SubmitRequest.find(params[:submit_request_id].to_i)
    end

    def submit_request_params
      params.require(:submit_request).permit(:task_id, :charge_id, :user_id, :status, :message)
    end
end
