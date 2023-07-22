class CreateUserChatRoom < ActiveRecord::Migration[6.1]
  def change
    create_table :user_chat_rooms do |t|
      t.integer :user_id
      t.integer :room_id
      t.timestamps null: false
    end
  end
end
