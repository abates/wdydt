class CreateActivityTypes < ActiveRecord::Migration
  def change
    create_table :activity_types do |t|
      t.string :name
      t.string :class_name
      t.string :plural_description
      t.string :singular_description

      t.timestamps null: false
    end
  end
end
