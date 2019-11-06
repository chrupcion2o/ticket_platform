class ChangeTypeToTicketType < ActiveRecord::Migration[6.0]
  def change
    rename_column :tickets, :type, :ticket_type
  end
end
