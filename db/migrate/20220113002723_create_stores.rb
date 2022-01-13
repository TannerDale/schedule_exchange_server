class CreateStores < ActiveRecord::Migration[6.1]
  def change
    create_table :stores do |t|
      t.string :street_address, null: false
      t.integer :zip_code, null: false
      t.integer :store_number, null: false
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
