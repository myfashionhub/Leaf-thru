class CreateReaderArticleJoins < ActiveRecord::Migration
  def change
    create_table :reader_article_joins do |t|
      t.string :reader_id
      t.string :article_id
      t.string :match_score
      t.string :reader_ranking

      t.timestamps
    end
  end
end
