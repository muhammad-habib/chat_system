class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :chat_number
      t.bigint :application_id
      t.integer :messages_count, default: 0
      t.timestamps
    end
    add_foreign_key :chats, :applications
  end
end
