class UsersController < ApplicationController
  before_action :login_user, only: [ :show, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @favorites_pictures = @user.favorite_pictures
  end

  def favorites
    @user = User.find(params[:id])
    @favorites_pictures = @user.favorite_pictures
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,:image,:image_cache)
  end

  def login_user
    if current_user.nil?
      redirect_to new_session_path, notice: "ログインしてください"
    end
  end

end
