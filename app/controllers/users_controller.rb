class UsersController < ApplicationController
  before_action :set_user, only: [:show, :following, :followers]

  def index
    @users = User.all
  end

  def show
  end

  def following
    @users = @user.followed_users
    render 'show_follow'
  end

  def followers
    @users = @user.followers
    render 'show_follow'
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
