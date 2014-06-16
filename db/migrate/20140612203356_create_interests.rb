class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :topic
      t.string :url1
      t.string :url2
      t.string :url3

      t.timestamps
    end
  end
end
