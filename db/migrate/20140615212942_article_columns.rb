class ArticleColumns < ActiveRecord::Migration
  def change
    rename_column :articles, :headline, :title
    add_column :articles, :shared_by, :string
    add_column :interests, :url1, :string
    add_column :interests, :url2, :string
    add_column :interests, :url3, :string
  end
end
