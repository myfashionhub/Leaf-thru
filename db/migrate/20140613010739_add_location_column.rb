class AddLocationColumn < ActiveRecord::Migration
  def change
    add_column :readers, :location, :string
  end
end
