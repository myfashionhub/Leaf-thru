class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :name
      t.string :url
      t.string :topic

      t.timestamps
    end
  end
end
