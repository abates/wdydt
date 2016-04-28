require 'rails_helper'

RSpec.describe ActivityField, type: :model do
  describe "creating a field" do
    it "should create a column on the specific table" do
      t = ActivityType.create(name: "some task")
      t.fields << ActivityField.create(name: "some column", field_type: "decimal")
      c = t.fields.first
      expect(ActiveRecord::Base.connection.column_exists?(t.table_name, c.column_name)).to be(true)
    end
  end

  describe "destroying a field" do
     it "should drop a column from the specific table" do
      t = ActivityType.create(name: "some task")
      t.fields << ActivityField.create(name: "some column", field_type: "decimal")
      c = t.fields.first
      c.destroy
      expect(ActiveRecord::Base.connection.column_exists?(t.table_name, c.column_name)).to be(false)
     end
  end
end
