class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :characters,      dependent: :destroy
  has_many :group_users,     dependent: :destroy
  has_many :permits,         dependent: :destroy
  has_many :groups,          through: :group_users
  has_many :messages,        dependent: :destroy
  has_many :direct_messages, dependent: :destroy
  has_many :entries,         dependent: :destroy
  has_many :rooms,           through: :entries
  has_many :notifications, dependent: :destroy

  has_one_attached :image

  def user_status
    if is_deleted == true
      "退会"
    else
      "有効"
    end
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

  validates :name, presence: true

  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end
end
