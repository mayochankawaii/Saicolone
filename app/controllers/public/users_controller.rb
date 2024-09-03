class Public::UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:index, :edit, :update, :destroy]
  before_action :ensure_guest_user, only: [:edit]

  def edit
    @user = current_user
  end

  def show
    if current_user
      @user = current_user
      @currentUserEntry=Entry.where(user_id: current_user.id)
      @userEntry=Entry.where(user_id: @user.id)
      unless @user.id == current_user.id
        @currentUserEntry.each do |cu|
          @userEntry.each do |u|
            if cu.room_id == u.room_id then
              @isRoom = true
              @roomId = cu.room_id
            end
          end
        end
        if @isRoom
        else
          @room = Room.new
          @entry = Entry.new
        end
      end
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

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end  
end
