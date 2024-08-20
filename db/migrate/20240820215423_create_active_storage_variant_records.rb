class CreateActiveStorageVariantRecords < ActiveRecord::Migration[7.2]
  def change
    create_table :active_storage_variant_records do |t|
      t.bigint :blob_id
      t.string :variation_digest

      t.timestamps
    end
    add_index :active_storage_variant_records, :blob_id
    add_index :active_storage_variant_records, :variation_digest, unique: true
  end
end
