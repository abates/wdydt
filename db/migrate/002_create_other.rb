class CreateOther < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :task
      t.decimal :hours
      t.text :notes

      t.timestamps null: false
    end

    create_table :expenses do |t|
      t.string :category
      t.decimal :amount
      t.text :notes

      t.timestamps null: false
    end

    create_table :mileage do |t|
      t.decimal :distance
      t.string :origin
      t.string :destination
      t.text :notes

      t.timestamps null: false
    end
  end
end
