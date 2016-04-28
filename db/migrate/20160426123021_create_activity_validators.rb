class CreateActivityValidators < ActiveRecord::Migration
  def change
    create_table :activity_validators do |t|
      t.references :activity_type, index: true, foreign_key: true
      t.references :activity_field, index: true, foreign_key: true
      t.text :description
      t.text :formula
      t.text :message

      t.timestamps null: false
    end
  end
end
