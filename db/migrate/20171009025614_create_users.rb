class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :people
      t.string :concept
      t.string :password

      t.timestamps null: false
    end
  end
end
