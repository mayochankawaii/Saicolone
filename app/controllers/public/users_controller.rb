class Public::UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def edit
    @user = current_user
  end

  def show
    if current_user
      @user = current_user
    else
      redirect_to new_user_session_path
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to mypage_path
    else
      render :edit
    end
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :email, :profile, :introduction)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to mypage_path
    end
  end
end
