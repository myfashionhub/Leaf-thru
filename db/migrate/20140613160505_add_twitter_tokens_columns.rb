class AddTwitterTokensColumns < ActiveRecord::Migration
  def change
    add_column :readers, :twitter_token, :string
    add_column :readers, :twitter_token_secret, :string
  end
end
