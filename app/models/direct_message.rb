class DirectMessage < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :content, presence: true, length: { maximum: 300 }
end
