class Public::DirectMessagesController < ApplicationController

  def create
    # メッセージをする対象の投稿(room)のインスタンスを作成
    @room = Room.find(params[:room_id])
    #投稿に紐づいたメッセージを作成
    @direct_message = @room.direct_messages.new(direct_message_params)
    # メッセージ投稿者(user)のidを代入
    @direct_message.user_id = current_user.id
    @direct_message.room_id = @room.id
    if @direct_message.save
      flash.now[:notice] = "メッセージの投稿に成功しました。"
    else
      flash.now[:alert] ="メッセージの投稿に失敗しました。"
    end
  end

  def destroy
    @room = Room.find(params[:room_id])
    @direct_message = DirectMessage.find(params[:id])
    @direct_message.destroy
    flash.now[:notice] = "メッセージを削除しました。"
  end

  private

  def direct_message_params
    params.require(:direct_message).permit(:content, :user_id, :room_id)
  end
end