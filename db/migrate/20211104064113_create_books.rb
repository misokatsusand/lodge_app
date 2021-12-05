class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.integer :user_id
      t.integer :room_id
      t.datetime :start
      t.datetime :end
      t.integer :number_of_people
      t.integer :total_price
      t.timestamps
    end
  end
end
