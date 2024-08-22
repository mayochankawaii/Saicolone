class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users, source: :user
  has_many :messages, dependent: :destroy
  has_many :group_characters, dependent: :destroy
  has_many :characters, through: :group_characters
  has_many :schedules
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'

  validates :title, presence: true
  validates :description, presence: true
end
