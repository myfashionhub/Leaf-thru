class ChangeTypeExtract < ActiveRecord::Migration
  def change
    remove_column :articles, :extract, :string
    add_column :articles, :extract, :text
  end
end
