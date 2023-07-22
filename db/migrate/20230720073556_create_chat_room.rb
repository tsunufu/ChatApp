class CreateChatRoom < ActiveRecord::Migration[6.1]
  def change
      create_table :chats do |t|
      t.timestamps null: false
    end
  end
end
