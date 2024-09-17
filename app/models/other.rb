class Other < ApplicationRecord
  belongs_to :character

  validates :status, presence: true
end
