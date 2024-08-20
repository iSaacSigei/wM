class AddForeignKeyToActiveStorageVariantRecords < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :active_storage_variant_records, :active_storage_blobs, column: :blob_id
  end
end
