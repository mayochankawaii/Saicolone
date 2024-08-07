class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :characters, dependent: :destroy
  has_many :group_users
  has_many :posts

  def user_status
    if is_deleted == true
      "退会"
    else
      "有効"
    end
  end

  validates :name, presence: true

end
