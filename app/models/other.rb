class Other < ApplicationRecord
  belongs_to :character

  validates :skill, presence: true
  validates :point, presence: true
end
