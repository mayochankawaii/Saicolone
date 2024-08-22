class Character < ApplicationRecord
  has_many :group_characters
  has_many :groups, through: :group_characters
  belongs_to :user#, optional: true
  belongs_to :genre

  has_one_attached :image
  # enum is_sold_out: { on_sale: 0, off_sale: 1 }
  validates :name, presence: true
  validates :status, presence: true
  validates :genre, presence: true

# 検索方法分岐
  def self.looks(search, word)
    if search == "partial"
      @character = Character.where("name LIKE?","%#{word}%")
    end
  end
end
