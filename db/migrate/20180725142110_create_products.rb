class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :owner_name
      t.text :details
      t.string :location
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
