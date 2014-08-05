class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.float :price
      t.integer :seller_id

      t.timestamps
    end
  end
end