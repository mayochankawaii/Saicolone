class CreateOthers < ActiveRecord::Migration[6.1]
  def change
    create_table :others do |t|
      t.references :character, foreign_key: true
      t.string :skill
      t.string :point

      t.timestamps
    end
  end
end
