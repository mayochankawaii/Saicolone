class GroupCharacter < ApplicationRecord
  belongs_to :character
  belongs_to :group
end
