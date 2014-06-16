class AddSocialColumns < ActiveRecord::Migration
  def change
    add_column :readers, :facebook_token, :string
    add_column :readers, :name, :string
    add_column :readers, :image, :string
    add_column :readers, :tagline, :string
    add_column :readers, :twitter_handle, :string
    add_column :readers, :facebook_uid, :string
  end
end
