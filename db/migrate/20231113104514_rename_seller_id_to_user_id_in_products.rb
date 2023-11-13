class RenameSellerIdToUserIdInProducts < ActiveRecord::Migration[7.1]
  def change
    rename_column :products, :seller_id, :user_id
  end
end
