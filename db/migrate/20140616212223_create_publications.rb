class CreatePublications < ActiveRecord::Migration
  def up
    create_table :publications do |t|
      t.string :name
      t.string :url
      t.string :category

      t.timestamps
    end
  end

  def down
    drop_table :publications
  end
end
