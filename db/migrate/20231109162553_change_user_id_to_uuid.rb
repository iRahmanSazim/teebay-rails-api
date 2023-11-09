class ChangeUserIdToUuid < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    remove_column :users, :id
    add_column :users, :id, :uuid, default: "gen_random_uuid()", primary_key: true, null: false
  end
end
