class CreateArticles < ActiveRecord::Migration
  def up
    create_table :articles do |t|
      t.text :url
      t.string :title
      t.string :publication
      t.text :extract
      t.string :date
      t.string :shared_by
      t.timestamps
    end
  end

  def down
    drop_table :articles
  end
end
