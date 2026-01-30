class CreateTables < ActiveRecord::Migration[8.1]
  def change
    create_table :tables do |t|
      t.datetime :start_time
      t.integer :capacity
      t.integer :remaining_seats

      t.timestamps
    end
  end
end
