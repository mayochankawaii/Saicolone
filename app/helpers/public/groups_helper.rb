module Public::GroupsHelper
  def get_dm_room_id(current_user, user)
    currentUserEntry = Entry.where(user_id: current_user.id)
    userEntry = Entry.where(user_id: user.id)
    common_room_ids = currentUserEntry.pluck(:room_id) & userEntry.pluck(:room_id)
    common_room_ids.first if common_room_ids.present?
  end
end
