class GroupCharacter < ApplicationRecord
  belongs_to :character
  belongs_to :genre
end
