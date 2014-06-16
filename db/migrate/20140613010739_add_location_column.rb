class AddLocationColumn < ActiveRecord::Migration
  def change
    add_column :readers, :location, :string
    add_column :readers, :twitter, :string
    add_column :readers, :facebook, :string
  end
end
