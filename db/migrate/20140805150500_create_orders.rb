class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :buyer, index: true
      t.boolean :closed, default: false

      t.timestamps
    end
  end
end
