class Public::MessagesController < ApplicationController

  def create
    # メッセージをする対象の投稿(group)のインスタンスを作成
    @group = Group.find(params[:group_id])
    #投稿に紐づいたメッセージを作成
    @message = @group.messages.new(message_params)
    # メッセージ投稿者(user)のidを代入
    @message.user_id = current_user.id
    @message.group_id = @group.id
    @message.score = Language.get_data(message_params[:content])  #この行を追加
    if @message.save
      flash.now[:notice] = "投稿しました"
    else
      flash.now[:alert] ="投稿に失敗しました"
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    @message = Message.find(params[:id])
    @message.destroy
    flash.now[:notice] = "メッセージを削除しました"
  end

  private
    def message_params
      params.require(:message).permit(:content, :user_id, :group_id)
    end
end