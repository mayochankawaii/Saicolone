class Public::GroupUsersController < ApplicationController
  before_action :authenticate_user!

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

