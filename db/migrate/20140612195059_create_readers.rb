class CreateReaders < ActiveRecord::Migration
  def change
    create_table :readers do |t|
      t.string :name
      t.string :email_validate
      t.string :password
      t.string :location

      t.timestamps
    end
  end
end
