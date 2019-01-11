class AddOmniauthToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :provider, :string, default: ''
    add_column :users, :uid, :string, default: ''
  end
end
