class CreateCharacters < ActiveRecord::Migration[6.1]
  def change
    create_table :characters do |t|
      t.integer :user_id
      t.integer :genre_id
      t.string :name
      t.text :status
      t.text :description

      t.timestamps
    end
  end
end
