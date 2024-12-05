class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders, id: :string do |t|
      t.references :merchant, null: false, foreign_key: true
      t.decimal :amount
      t.boolean :disbursed

      t.timestamps
    end
  end
end
