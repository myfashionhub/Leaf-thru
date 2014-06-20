class CreateReaders < ActiveRecord::Migration
  def change
    create_table :readers do |t|
      t.string :name
      t.string :email_validate
      t.string :password
      t.string :location
      t.string :twitter_token
      t.string :twitter_token_secret
      t.string :twitter_handle
      t.string :facebook_token
      t.string :facebook_uid
      t.string :tagline
      t.string :image
      t.string :email,            :null => false
      t.string :crypted_password, :null => false
      t.string :salt,             :null => false

      t.timestamps
    end
    add_index :readers, :email, unique: true

  end
end
