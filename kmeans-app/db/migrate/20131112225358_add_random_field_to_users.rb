class AddRandomFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :random_field, :text
  end
end
