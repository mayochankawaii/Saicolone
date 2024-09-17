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

  def initial_sanity
    (total3 || 0) * 5
  end

  def idea
    (total7 || 0) * 5
  end

  def knowledge
    (total8 || 0) * 5
  end

  def db_result
    total1 = (self.total1 || 0)
    total6 = (self.total6 || 0)
    db_total = total1 + total6

    if db_total >= 2 && db_total <= 12
      '-1D6'
    elsif db_total >= 13 && db_total <= 16
      '-1D4'
    elsif db_total >= 17 && db_total <= 24
      '+0'
    elsif db_total >= 25 && db_total <= 32
      '+1D4'
    elsif db_total >= 33 && db_total <= 40
      '+1D6'
    else
      '+1D6'
    end
  end

# 検索方法分岐
  def self.looks(search, word)
    if search == "partial"
      @character = Character.where("name LIKE?","%#{word}%")
    end
  end
end
