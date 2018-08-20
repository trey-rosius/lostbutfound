class AddLocationsRefToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :location, foreign_key: true
  end
end
