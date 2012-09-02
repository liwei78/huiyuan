class AddOnlineToUsers < ActiveRecord::Migration
  def change
    add_column :users, :online, :boolean, :default => false
    add_column :users, :last_login, :datetime
  end
end
