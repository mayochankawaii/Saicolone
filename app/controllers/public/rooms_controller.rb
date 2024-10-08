class Public::RoomsController < ApplicationController
  before_action :authenticate_user!
  include RoomsHelper

  def index
    if current_user
      # @rooms = current_user.rooms
      @rooms = current_user.rooms.joins(:direct_messages).includes(:direct_messages).order("direct_messages.created_at DESC")
    else
      redirect_to new_user_session_path, alert: 'ログインが必要です。'
    end
  end

  def create
    @room = Room.create
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to "/rooms/#{@room.id}"
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id,room_id: @room.id).present?
      @direct_messages = @room.direct_messages
      @direct_message = DirectMessage.new
      @entries = @room.entries
      @myUserId = current_user.id #Roomで相手の名前表示するために記述
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
