class CreateGroupCharacters < ActiveRecord::Migration[6.1]
  def change
    create_table :group_characters do |t|
      t.integer :character_id
      t.integer :group_id

      t.timestamps
    end
  end
end
