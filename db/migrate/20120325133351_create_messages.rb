class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.boolean :publish, :default => false
      t.string  :title
      t.text    :content
      t.string  :download_url

      t.timestamps
    end
  end
end
