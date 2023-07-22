class Messages < ActiveRecord::Migration[6.1]
  def change
      create_table :messages do |t|
      t.integer :user_id
      t.text :content
      t.timestamps null: false
    end
  end
end
