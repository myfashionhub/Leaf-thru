class ChangeReaderarticleJoin < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.column :reader_id, :integer
      t.column :article_id, :integer
      t.column :match_score, :integer
      t.column :reader_ranking, :integer
    end
  end
end
