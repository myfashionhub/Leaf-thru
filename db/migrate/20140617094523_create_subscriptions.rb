class CreateSubscriptions < ActiveRecord::Migration
  def up
    create_table :subscriptions do |t|
      t.integer :reader_id
      t.integer :publication_id

      t.timestamps
    end
  end

  def down
    drop_table :subscriptions
  end
end
