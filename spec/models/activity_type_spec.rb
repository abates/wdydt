require 'rails_helper'
require 'ostruct'

RSpec.describe ActivityType, type: :model do
  describe "creating an ActivityType" do
    it "should set the class name" do
      t = ActivityType.create(name: "some task")
      expect(t.class_name).to eq("SomeTask")
    end

    it "should create a table" do
      expect(ActiveRecord::Base.connection.table_exists?('some_tasks')).to be(false)
      t = ActivityType.create(name: "some task")
      expect(ActiveRecord::Base.connection.table_exists?('some_tasks')).to be(true)
    end
  end

  describe "udpating an ActivityType" do
    it "should prohibit changing the name" do
      t = ActivityType.create(name: "some task")
      expect(t.class_name).to eq("SomeTask")
      t.name = "new task"
      expect(t.invalid?)
      expect(t.errors[:name]).not_to be_empty
    end
  end

  describe "destroying an ActivityType" do
    it "should drop the table" do
      t = ActivityType.create(name: "some task")
      expect(ActiveRecord::Base.connection.table_exists?('some_tasks')).to be(true)
      t.destroy!
      expect(ActiveRecord::Base.connection.table_exists?('some_tasks')).to be(false)
    end
  end

  describe "extra attributes" do
    it "should constantize the class name" do
      t = ActivityType.create(name: "some task")
      expect(t.activity_class).to be(SomeTask)
    end

    it "should pluralize the name" do
      t = ActivityType.create(name: "some task")
      expect(t.plural_name).to eq("some task".pluralize)
    end

    it "should return the form fields with the activity day added" do
      t = ActivityType.create(name: "some task")
      expect(t.form_fields).to eq([OpenStruct.new(name: "day", field_type: "Date", column_name: "day")])
    end
  end
end
