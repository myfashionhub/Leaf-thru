class SorceryCore < ActiveRecord::Migration

  def change
    drop_table :readers

    create_table :readers do |t|
      t.string :email,            :null => false
      t.string :crypted_password, :null => false
      t.string :salt,             :null => false

      t.timestamps
    end

    add_index :readers, :email, unique: true
  end
end
