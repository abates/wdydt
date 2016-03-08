require 'rails_helper'

RSpec.describe ActivityType, type: :model do
  describe "setting the class_name" do
    it "should set the class name when creating a new ActivityType" do
      t = ActivityType.create(name: "some task")
      expect(t.class_name).to eq("SomeTask")
    end

    it "should prohibit changing the name when updating a ActivityType" do
      t = ActivityType.create(name: "some task")
      expect(t.class_name).to eq("SomeTask")
      t.name = "new task"
      expect(t.invalid?)
    end
  end

  describe "the table" do
    it "should create a table when a new ActivityType has been created" do
      expect(ActiveRecord::Base.connection.table_exists?('some_tasks')).to be(false)
      t = ActivityType.create(name: "some task")
      expect(ActiveRecord::Base.connection.table_exists?('some_tasks')).to be(true)
    end

    it "shoule drop the table when an ActivityType is deleted" do
      t = ActivityType.create(name: "some task")
      expect(ActiveRecord::Base.connection.table_exists?('some_tasks')).to be(true)
      t.destroy!
      expect(ActiveRecord::Base.connection.table_exists?('some_tasks')).to be(false)
    end
  end
end
