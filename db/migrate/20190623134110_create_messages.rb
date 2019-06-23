class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :message_number
      t.text :body
      t.bigint :chat_id
      t.timestamps
    end
    add_foreign_key :messages, :chats
  end
end
