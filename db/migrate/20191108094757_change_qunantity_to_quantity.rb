class ChangeQunantityToQuantity < ActiveRecord::Migration[6.0]
  def change
    rename_column :tickets, :qunantity, :quantity
  end
end
