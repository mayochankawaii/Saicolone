class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :content, presence: true, length: { maximum: 300 }
end
