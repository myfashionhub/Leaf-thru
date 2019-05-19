class CreateTables < ActiveRecord::Migration[5.1]
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

    create_table :bookmarks do |t|
      t.column :reader_id, :integer
      t.column :article_id, :integer
      t.column :match_score, :integer
      t.column :reader_ranking, :integer
      t.string :pocket_id

      t.timestamps
    end

    create_table :publications do |t|
      t.string :name
      t.string :url
      t.string :topic

      t.timestamps
    end

    create_table :readers do |t|
      t.string :name
      t.string :password
      t.string :location
      t.string :tagline
      t.string :image
      t.string :email,            :null => false
      t.string :crypted_password, :null => false
      t.string :salt,             :null => false

      t.string :facebook_token
      t.string :facebook_uid
      t.string :pocket_token
      t.string :pocket_username
      t.string :twitter_token
      t.string :twitter_token_secret
      t.string :twitter_handle

      t.timestamps
    end
    add_index :readers, :email, unique: true

    create_table :subscriptions do |t|
      t.integer :reader_id
      t.integer :publication_id

      t.timestamps
    end
  end

  def down
    drop_table :articles
    drop_table :bookmarks
    drop_table :publications
    drop_table :readers
    drop_table :subscriptions
  end
end
