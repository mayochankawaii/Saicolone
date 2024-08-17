class GroupChannel < ApplicationCable::Channel
  def subscribed
    stream_from "group_channel_#{params['group']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create! content: data['message'], user_id: current_user.id, group_id: params['group']
  end
end
