class Admin::GroupUsersController < ApplicationController

  def create
    group = Group.find(params[:group_id])
    user = current_user
    group.users << user
    redirect_to group_path(group.id)
  end

  def destroy
    group = Group.find(params[:group_id])
    user = current_user
    group.users.delete(user)
    redirect_to groups_path
  end
end

