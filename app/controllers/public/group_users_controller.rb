class Public::GroupUsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @group = Group.find(params[:group_id])
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
  end

  def create
    group = Group.find(params[:group_id])
    permit = Permit.find(params[:permit_id])
    user = permit.user # 承認待ちのユーザーを取得します
    group.users << user # 承認待ちのユーザーをグループに追加します
    permit.destroy # 承認待ちリストから削除します
    redirect_to request.referer
  end

  def destroy
    group = Group.find(params[:group_id])
    user = current_user
    group.users.delete(user)
    redirect_to groups_path
  end
end

