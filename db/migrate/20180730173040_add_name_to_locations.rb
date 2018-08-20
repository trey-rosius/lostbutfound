class AddNameToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :name, :string
  end
end
