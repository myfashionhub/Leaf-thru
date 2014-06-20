class CreateArticles < ActiveRecord::Migration
  def change
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
end
