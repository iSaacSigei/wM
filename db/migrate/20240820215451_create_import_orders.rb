class CreateImportOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :import_orders do |t|
      t.string :import_from
      t.string :product
      t.integer :units
      t.text :product_description
      t.string :product_link
      t.string :company_name
      t.string :address
      t.string :city
      t.string :state_province
      t.string :contact
      t.boolean :request_quotation
      t.integer :user_id

      t.timestamps
    end
    add_index :import_orders, :user_id
  end
end
