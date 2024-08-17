class MessageBroadcastJob < ApplicationJob
  queue_as :default

  # ブロードキャスト(一つのネットワークの中にあるすべてのホストに対してデータを送る。)
  def perform(message)
    channel_name = "group_channel_#{message.group_id}"
    data = { message: render_message(message) }

    ActionCable.server.broadcast(channel_name, data)
  end

  # app/views/message/_message.html.erbを呼び出す。
  private
  def render_message(message)
    ApplicationController.renderer.render(partial: 'public/messages/message', locals: { message: message })
  end
end
