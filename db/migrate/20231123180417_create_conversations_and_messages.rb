class CreateConversationsAndMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :conversations, id: :uuid do |t|
      t.references :product, type: :uuid, null: false, foreign_key: true
      t.uuid :participant_ids, array: true, default: []
      t.timestamps
    end

    create_table :messages, id: :uuid do |t|
      t.references :conversation, type: :uuid, null: false, foreign_key: true
      t.references :sender, type: :uuid, null: false, foreign_key: { to_table: :users }
      t.text :body
      t.timestamps
    end
  end
end
