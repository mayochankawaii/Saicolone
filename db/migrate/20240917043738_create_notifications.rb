class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :notifiable, polymorphic: true, null: false
      t.boolean :read, default: false, null: false
      t.integer :group_id
      t.integer :message_id

      t.timestamps
    end
  end
end
