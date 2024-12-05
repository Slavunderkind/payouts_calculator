class CreateMerchants < ActiveRecord::Migration[8.0]
  def change
    create_table :merchants do |t|
      t.string :uuid
      t.string :reference
      t.string :email
      t.date :live_on
      t.string :disbursement_frequency
      t.decimal :minimum_monthly_fee

      t.timestamps
    end
  end
end
