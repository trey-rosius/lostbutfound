class RemoveLocationFromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :location, :string
  end
end
