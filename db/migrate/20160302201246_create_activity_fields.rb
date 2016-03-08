class CreateActivityFields < ActiveRecord::Migration
  def change
    create_table :activity_fields do |t|
      t.references :activity_type, index: true, foreign_key: true
      t.string :name
      t.string :field_type

      t.timestamps null: false
    end
  end
end
