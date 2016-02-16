class CreateWdydt < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.datetime :date
      t.timestamps null: false
    end

    create_table :activities do |t|
      t.date :day
      t.integer :actable_id
      t.string  :actable_type
      t.timestamps null: false
    end
  end
end
