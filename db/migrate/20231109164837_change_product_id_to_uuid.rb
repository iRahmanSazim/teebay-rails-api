class ChangeProductIdToUuid < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    remove_column :products, :id
    add_column :products, :id, :uuid, default: "gen_random_uuid()", primary_key: true, null: false
  end
end
