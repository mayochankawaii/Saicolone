class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true
  belongs_to :group, optional: true 
  belongs_to :message, optional: true
  belongs_to :direct_message, optional: true
end
