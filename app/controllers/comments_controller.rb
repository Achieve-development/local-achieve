class CommentsController < ApplicationController

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
    if @comment.save
      redirect_to @comment, notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @comment, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end


  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to comments_url, notice: 'Comment was successfully destroyed.'
  end

private
  def comment_params
    params.require(:comment).permit(:blog_id, :user_id, :content)
  end

end
