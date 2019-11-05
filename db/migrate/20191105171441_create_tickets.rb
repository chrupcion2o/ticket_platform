class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.integer :qunantity
      t.string :type
      t.decimal :price
      t.string :currency
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
