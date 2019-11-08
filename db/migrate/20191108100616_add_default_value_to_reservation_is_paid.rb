class AddDefaultValueToReservationIsPaid < ActiveRecord::Migration[6.0]
  def change
    change_column :reservations, :is_paid, :boolean, default: false, null: false
  end
end
