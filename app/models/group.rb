class Group < ApplicationRecord
  has_many :users
  has_many :posts
  has_many :group_characters
  has_many :schedules
end
