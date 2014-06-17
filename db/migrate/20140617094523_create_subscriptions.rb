class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|

      t.integer :reader_id
      t.integer :publication_id

      t.timestamps
    end
  end
end
