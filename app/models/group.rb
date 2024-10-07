class Group < ApplicationRecord
  has_many :group_users,      dependent: :destroy
  has_many :permits,          dependent: :destroy
  has_many :users,            through: :group_users, source: :user
  has_many :messages,         dependent: :destroy
  has_many :group_characters, dependent: :destroy
  has_many :characters,       through: :group_characters
  has_many :schedules
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  has_one_attached :image

  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "partial"
      return Group.where("title LIKE ?", "%#{word}%")
    end
  end
end
