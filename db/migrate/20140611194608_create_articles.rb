class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :url
      t.string :headline
      t.string :publication
      t.string :extract
      t.string :date

      t.timestamps
    end
  end
end
