class CreateUserMessages < ActiveRecord::Migration
  def change
    create_table :user_messages do |t|
      t.integer :user_id
      t.boolean :read, :default => false
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
