class Character < ApplicationRecord
  has_many :group_characters
  belongs_to :user
  belongs_to :genre
end
