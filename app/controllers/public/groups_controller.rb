class Public::GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :owner?, only: [:edit, :update, :destroy]

  def index
    @groups = Group.all
    @group_lists = Group.all.order(:id)
    # @group_joining = GroupUser.where(user_id: current_user.id)
    # @group_lists_none = "You don't join any groups."
  end

  def show
    @group = Group.find(params[:id])
    @messages = @group.messages#.order(created_at: :desc)
    @message = Message.new
  end

  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = Group.new(group_params)
    @group.owner = current_user
    if @group.save
      @group.users << current_user
      redirect_to group_path(@group.id)
    else
      render :new
    end

    @group_character = GroupCharacter.new(group_character_params)
    @group_character.customer_id = current_customer.id
    @group_character.character_id = group_character_params[:character_id]
    if GroupCharacter.find_by(character_id: params[:group_character][:character_id]).present?
      existing_group_character = GroupCharacter.find_by(character_id: params[:group_character][:character_id])
      existing_group_character.amount += params[:group_character][:amount].to_i
      existing_group_character.update(amount: existing_group_character.amount)
      redirect_to group_characters_path
    else
      @group_character.save
      redirect_to group_path(@group.id)
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group.id)
    else
      render :edit
    end
  end

  def destroy
    @group_character = current_customer.group_characters.find(params[:id])
    @group_character.destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end

  def owner?
    group = Group.find(params[:id])
    if group.owner != current_user
      redirect_to group_path(group.id)
    end
  end
end