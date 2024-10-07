class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :content, presence: true, length: { maximum: 300 }
end
