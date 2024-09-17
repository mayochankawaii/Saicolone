class Character < ApplicationRecord
  has_many :group_characters
  has_many :groups,                      through: :group_characters
  belongs_to :user
  belongs_to :genre
  has_many :others,                      dependent: :destroy
  accepts_nested_attributes_for :others, allow_destroy: true

  has_one_attached :image
  validates :name, presence: true
  validates :status, presence: true
  validates :genre, presence: true


  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end
# 検索方法分岐
  def self.looks(search, word)
    if search == "partial"
      @character = Character.where("name LIKE?","%#{word}%")
    end
  end
end
