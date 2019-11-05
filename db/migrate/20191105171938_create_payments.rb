class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.decimal :price
      t.string :currency
      t.string :status
      t.references :reservation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
