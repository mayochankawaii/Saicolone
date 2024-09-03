class AddScoreToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :score, :decimal, precision: 5, scale: 3
  end
end
