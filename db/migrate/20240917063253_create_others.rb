class CreateOthers < ActiveRecord::Migration[6.1]
  def change
    create_table :others do |t|
      t.references :character, foreign_key: true
      t.string :skill, null: false
      t.string :point, null: false

      t.timestamps
    end
  end
end
