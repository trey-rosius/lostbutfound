class AddRetrievedToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :retrieved, :boolean,default: false
  end
end
