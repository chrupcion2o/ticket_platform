class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.interger :quantity
      t.boolean :is_paid
      t.references :ticket, null: false, foreign_key: true

      t.timestamps
    end
  end
end
