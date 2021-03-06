class BlogsController < ApplicationController
  before_action :authenticate_user!
  before_action :follow_user?, only: [:index, :show]

  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
    @comment = @blog.comments.build
    @comments = @blog.comments
  end

  def new
    @blog = Blog.new
  end

  def edit
    @blog = current_user.blogs.find(params[:id])
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id

    if @blog.save
      redirect_to @blog, notice: 'Blog was successfully created.'
    else
      render :new
    end
  end

  def update
    @blog = current_user.blogs.find(params[:id])
    if @blog.update(blog_params)
      redirect_to @blog, notice: 'Blog was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @blog = current_user.blogs.find(params[:id])
    @blog.destroy
    redirect_to blogs_url, notice: 'Blog was successfully destroyed.'
  end

  private
    def blog_params
      params.require(:blog).permit(:title, :content)
    end

    def follow_user?
      @follow_user_ids = User.from_users_followed_by(current_user).ids
    end
end
