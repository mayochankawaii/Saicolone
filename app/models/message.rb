class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group

  # データ保存後にMessageBroadcastJobのperformメソッドを実行,引数はself
  after_create_commit { MessageBroadcastJob.perform_later self }
end
