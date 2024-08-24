class Public::GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :owner?, only: [:edit, :update, :destroy]

  def index
    @groups = Group.all
    @group_lists = Group.all.order(:id)
  end

  def show
    # @character = Character.find(params[:id])
    @group = Group.find(params[:id])
    @messages = @group.messages#.order(created_at: :desc)
    @message = Message.new
    @characters = current_user.characters
    @character_lists = @group.characters
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
    # @group_character = current_user.group_characters.find(params[:id])
    @group_character.destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to groups_path
  end

  def play_character
    @group = Group.find(params[:id])
    @characters = current_user.characters
    @character_lists = @group.characters
    render "play_character"
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