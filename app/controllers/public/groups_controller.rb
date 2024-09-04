class Public::GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :owner?, only: [:edit, :update, :destroy, :permits]

  def index
    if current_user
      @groups = current_user.groups
      @group_lists = Group.all.order(:id)
    else
      redirect_to new_user_session_path, alert: 'ログインが必要です。'
    end
  end

  def show
    @group = Group.find(params[:id])
    @messages = @group.messages
    @message = Message.new
    if user_signed_in?
    @characters = current_user.characters
    end
    @character_lists = @group.characters

    @user = User.find(params[:id])
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

  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = Group.new(group_params)
    @group.owner = current_user
    if @group.save
      @group.users << current_user
      redirect_to group_path(@group.id), notice: 'グループを作成しました！'
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
      redirect_to group_path(@group.id), notice: '編集を完了しました'
    else
      render :edit
    end
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to groups_path, alert: 'グループを削除しました'
  end

  def play_character
    @group = Group.find(params[:id])
    @characters = current_user.characters
    @character_lists = @group.characters
    render "play_character"
  end

  def permits
    @group = Group.find(params[:id])
    @permits = @group.permits.page(params[:page])
  end

  private

  def group_params
    params.require(:group).permit(:title, :description, :image)
  end

  def owner?
    group = Group.find(params[:id])
    if group.owner != current_user
      redirect_to group_path(group.id)
    end
  end
end