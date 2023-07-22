class ChengeColumnRoomIdToChatId < ActiveRecord::Migration[6.1]
  def change
    rename_column :user_chat_rooms, :room_id, :chat_id
    rename_column :messages, :room_id, :chat_id
  end
end
