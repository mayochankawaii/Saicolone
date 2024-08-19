class GroupChannel < ApplicationCable::Channel
  def subscribed
    stream_from "group_channel_#{params['group']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create! content: data['message'], user_id: current_user.id, group_id: params['group']
    # ActionCable.server.broadcast "group_channel_#{params['group_id']}", message: render_message(message), message_user: current_user.id
  end

  def destroy(data)
    message = Message.find_by(id: data['id'])
    if message
      message.destroy
      ActionCable.server.broadcast "group_channel_#{params['group']}", { id: data['id'] }
    end
  end

end
