class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :Post
      t.string :Character
      t.string :Genre

      t.timestamps
    end
  end
end
