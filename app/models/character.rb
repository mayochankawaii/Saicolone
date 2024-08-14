class Character < ApplicationRecord
  has_many :group_characters
  belongs_to :user#, optional: true
  belongs_to :genre

  has_one_attached :image
  # enum is_sold_out: { on_sale: 0, off_sale: 1 }
  validates :name, presence: true
  validates :status, presence: true
  validates :genre, presence: true

end
