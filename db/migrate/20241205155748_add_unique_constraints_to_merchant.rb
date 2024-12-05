class AddUniqueConstraintsToMerchant < ActiveRecord::Migration[8.0]
  def change
    add_index :merchants, :uuid, unique: true
    add_index :merchants, :reference, unique: true
    add_index :merchants, :email, unique: true
  end
end
