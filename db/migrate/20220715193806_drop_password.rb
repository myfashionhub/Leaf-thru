class DropPassword < ActiveRecord::Migration[7.0]
  def change
    remove_column :readers, :password
  end
end
