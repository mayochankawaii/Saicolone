class Admin::GroupsController < ApplicationController

  def index
    @group = Group.new
    @groups = Group.all
    @group_lists = Group.all.order(:id)
  end

  def show
    @group = Group.find(params[:id])
    @messages = @group.messages
    @message = Message.new
    @character_lists = @group.characters
  end

  def edit
    @group = Group.find(params[:id])
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to admin_groups_path
  end

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end
end