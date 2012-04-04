class AddVideocodeToMessages < ActiveRecord::Migration
  def change
    add_column :messages,      :videocode, :string
    add_column :user_messages, :videocode, :string
  end
end
