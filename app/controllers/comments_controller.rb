class CommentsController < ApplicationController
  before_action :authenticate_user!
  after_action :sending_pusher, only: [:create]

  def index
    @comments = Comment.all
  end


  def show
    @comment = Comment.find(params[:id])
  end


  def new
    @comment = Comment.new
  end


  def edit
    @comment = current_user.comments.find(params[:id])
  end


  def create
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    @notification = @comment.notifications.build(recipient_id: @blog.user_id, sender_id: current_user.id)
    respond_to do |format|

      if @comment.save
        @comments = @comment.blog.comments
        @comment = Comment.new
        format.html { redirect_to blog_path(@comment.blog_id) }
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @comment = current_user.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to blog_path(@comment.blog_id)
    else
      render :edit
    end
  end


  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    @comments = @comment.blog.comments
    respond_to do |format|
      format.html { redirect_to blog_path(@comment.blog) }
      format.js { render :index }
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:blog_id, :user_id, :content)
    end

    def sending_pusher
      Notification.sending_pusher(@notification.recipient_id)
    end

end
