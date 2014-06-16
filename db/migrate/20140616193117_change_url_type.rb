class ChangeUrlType < ActiveRecord::Migration
  def change
    remove_column :articles, :url, :string
    add_column :articles, :url, :text
  end
end
