class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :pass
      t.string :icon_name
      t.text :introduce
      t.timestamps
    end
  end
end
