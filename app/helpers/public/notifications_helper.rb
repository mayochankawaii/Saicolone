module Public::NotificationsHelper
  def notification_message(notification)
    case notification.notifiable_type
    when "Message"
      "#{notification.notifiable.user.name}さんが#{notification.notifiable.message}を送信しました"
    end
  end
end
