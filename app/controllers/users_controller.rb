class UsersController < ApplicationController
  before_action :login_user, only: [ :show, :update, :destroy, :edit]
  before_action :ensure_correct_user, only: [ :show, :update, :destroy, :edit]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path(@user.id), notice: "登録が完了しました。ログインしてください。"
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @favorites_pictures = @user.favorite_pictures
  end

  def favorite_index
    @user = User.find(params[:id])
    @favorites_pictures = @user.favorite_pictures
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path ,notice: "プロフィールを編集しました！"
    else
      render 'edit'
    end
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

  def ensure_correct_user
    @user = User.find_by(id:params[:id])
    if @user.id != @current_user.id
      flash[:notice] = "権限がありません！"
      redirect_to pictures_path
    end
  end

end
