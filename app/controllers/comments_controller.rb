class CommentsController < ApplicationController
  before_action :authenticate_user!

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
    @comment = Comment.find(params[:id])
  end


  def create
    @comment = Comment.new(comment_params)
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
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to blog_path(@comment.blog_id)
    else
      render :edit
    end
  end


  def destroy
    @comment = Comment.find(params[:id])
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

end
