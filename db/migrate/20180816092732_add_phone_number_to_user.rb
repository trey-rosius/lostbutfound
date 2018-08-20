class AddPhoneNumberToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :phoneNumber, :string
  end
end
