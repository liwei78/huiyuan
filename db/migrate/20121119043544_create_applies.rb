class CreateApplies < ActiveRecord::Migration
  def change
    create_table :applies, :options => "CHARSET=utf8" do |t|
      t.string :name
      t.string :phone
      t.string :telphone
      t.string :email
      t.string :address

      t.timestamps
    end
  end
end
