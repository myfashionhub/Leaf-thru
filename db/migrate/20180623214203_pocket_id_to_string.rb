class PocketIdToString < ActiveRecord::Migration
  def change
    change_column :bookmarks, :pocket_id, :string
  end
end
