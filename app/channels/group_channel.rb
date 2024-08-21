class GroupChannel < ApplicationCable::Channel
  def subscribed
    stream_from "group_channel_#{params['group']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = Message.create! content: data['message'], user_id: current_user.id, group_id: params['group']
    # template = ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message, current_user: current_user }) # current_user変数にconnection.rbで取得したcurrent_userを設定
    # template = ApplicationController.render_with_signed_in_user(user, 'messages/message', locals: { message: message, current_user: current_user })
    # ActionCable.server.broadcast "group_channel_#{params['group_id']}", group: render_group(group), other: render_other(group), group_user: current_user.id #変更
  end

  def destroy(data)
    message = Message.find_by(id: data['id'])
    if message
      message.destroy
      ActionCable.server.broadcast "group_channel_#{params['group']}", { id: data['id'] }
    end
  end

  private

  def render_group(group)
    ApplicationController.renderer.render( partial: 'groups/current', locals: { group: group, current_user: current_user})
    #コメントユーザー側のパーシャル
  end

  def render_groupother(group)
    ApplicationController.renderer.render( partial: 'groups/other', locals: { group: group, current_user: current_user})
    #コメントユーザー以外のパーシャル
  end
end
