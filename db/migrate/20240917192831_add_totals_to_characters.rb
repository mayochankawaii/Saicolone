class AddTotalsToCharacters < ActiveRecord::Migration[6.1]
  def change
    add_column :characters, :SA1, :integer
    add_column :characters, :SA2, :integer
    add_column :characters, :SA3, :integer
    add_column :characters, :SA4, :integer
    add_column :characters, :SA5, :integer
    add_column :characters, :SA6, :integer
    add_column :characters, :SA7, :integer
    add_column :characters, :SA8, :integer
    add_column :characters, :SB1, :integer
    add_column :characters, :SB2, :integer
    add_column :characters, :SB3, :integer
    add_column :characters, :SB4, :integer
    add_column :characters, :SB5, :integer
    add_column :characters, :SB6, :integer
    add_column :characters, :SB7, :integer
    add_column :characters, :SB8, :integer
    add_column :characters, :SB9, :integer
    add_column :characters, :SB10, :integer
    add_column :characters, :total1, :integer
    add_column :characters, :total2, :integer
    add_column :characters, :total3, :integer
    add_column :characters, :total4, :integer
    add_column :characters, :total5, :integer
    add_column :characters, :total6, :integer
    add_column :characters, :total7, :integer
    add_column :characters, :total8, :integer
    add_column :characters, :total9, :integer
    add_column :characters, :total10, :integer
  end
end
