class AddPocketIdToBookmark < ActiveRecord::Migration
  def change
    add_column :bookmarks, :pocket_id, :integer
  end
end
