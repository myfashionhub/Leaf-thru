class PocketCredentials < ActiveRecord::Migration
  def up
    add_column :readers, :pocket_token, :string
    add_column :readers, :pocket_username, :string
  end

  def down
    remove_column :readers, :pocket_token
    remove_column :readers, :pocket_username
  end
end
