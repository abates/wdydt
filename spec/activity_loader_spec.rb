require "rails_helper"

RSpec.describe ActivityLoader do
  describe "concrete activity types" do
    describe "extra attributes" do
      it "should constantize the class name" do
        t = ActivityType.create(name: "some task")
        expect(t.activity_class).to be(SomeTask)
      end

      it "should pluralize the name" do
        t = ActivityType.create(name: "some task")
        expect(t.plural_name).to eq("some task".pluralize)
      end

      describe "an activity's description" do
        t = nil
        before :each do
          t = ActivityType.create(name: "some task", singular_description: "Did %{task}")
          t.fields << ActivityField.create(name: "task", field_type: "string")
          #SomeTask.reset_column_information
          SomeTask.create(task: "foo")
        end

        it "should properly interpolate the description" do
          s = SomeTask.first
          expect(s.description).to eq("Did foo")
        end

        it "should warn about missing keys" do
          t.singular_description = "Did %{foo}"
          t.save!

          s = SomeTask.first
          expect(Rails.logger).to receive(:error).with("Failed to generate description: key{foo} not found.  Description string: #{t.singular_description}")
          expect(s.description).to eq("")
        end
      end

      it "should provide access to the ActivityType instance" do
        t = ActivityType.create!(name: "some task", singular_description: "Did %{task}")
        s = SomeTask.create()
        expect(s.activity_type).to eq(t)
      end
    end
  end

  describe "reloading" do
    it "should not reload if the activity_types table is missing" do
      if ActiveRecord::Base.connection.table_exists? 'activity_types'
        ActiveRecord::Base.connection.rename_table 'activity_types', 'activity_types_tmp'
      end

      expect(Rails.logger).to receive(:warn).with("activity_types table does not appear to exist so no ActivityType constants are being created")
      ActivityLoader.reload!

      if ActiveRecord::Base.connection.table_exists? 'activity_types_tmp'
        ActiveRecord::Base.connection.rename_table 'activity_types_tmp', 'activity_types'
      end
    end

    it "should warn that constants are not redefined" do
      t = ActivityType.create!(name: "some task", singular_description: "Did %{task}")
      expect(Rails.logger).to receive(:warn).with("#{t.class_name} is already loaded, cannot reload it")
      ActivityLoader.load!(t)
    end
  end
end
