class AddForeignKeyToExportOrders < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :export_orders, :users, column: :user_id
  end
end
