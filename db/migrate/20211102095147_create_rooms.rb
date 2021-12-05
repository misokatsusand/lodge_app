class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :user_id
      t.string :area
      t.text :comment
      t.string :image_name
      t.integer :price_per_day_and_person
      t.timestamps
    end
  end
end
