class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.string :seller_id

      t.timestamps
    end
  end
end
