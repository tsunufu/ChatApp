class Users < ActiveRecord::Migration[6.1]
  def change
      create_table :users do |t|
      t.string :name
      t.string :status
      t.timestamps null: false
    end
  end
end
