class ChangeEmailColumn < ActiveRecord::Migration
  def change
    rename_column :readers, :email_validate, :email
  end
end
