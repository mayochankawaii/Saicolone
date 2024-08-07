class Public::UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def show
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to mypage_path
  end

  def withdraw
    @user = user.find(current_user.id)
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile, :introduction)
  end
end
