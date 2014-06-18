class CreateReaderInterestJoins < ActiveRecord::Migration
  def change
    create_table :reader_interest_joins do |t|
      t.string :reader_id
      t.string :interest_id

      t.timestamps
    end
  end
end
