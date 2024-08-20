class AddForeignKeyToImportOrders < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :import_orders, :users, column: :user_id
  end
end
