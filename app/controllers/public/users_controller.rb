class Public::UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:index, :edit, :update, :destroy]

  def edit
    @user = current_user
  end

  def show
    if current_user
      @user = current_user
    else
      redirect_to new_user_session_path, alert: 'ログインが必要です。'
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to mypage_path, notice: '編集を完了しました'
    else
      render :edit
    end
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path, alert: '退会処理を実行いたしました'
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :email, :profile, :description, :image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to mypage_path
    end
  end
end
