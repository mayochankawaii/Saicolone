class CreateOthers < ActiveRecord::Migration[6.1]
  def change
    create_table :others do |t|
      t.references :character, foreign_key: true
      t.string :status, null: false

      t.timestamps
    end
  end
end
