require 'rails_helper'

RSpec.describe Activity, type: :model do
  describe "extra attributes" do
    before :each do
      @activity_type = ActivityType.create(name: "some task", singular_description: "foobar")
      @specific_activity = @activity_type.activity_class.create()
      @activity = @specific_activity.activity
    end

    it "should expose the underlying specific activity's description" do
      expect(@activity.description).to eq(@specific_activity.description)
    end

    it "should expse the underlying specfic activity's type" do
      expect(@activity.activity_type).to eq(@activity_type)
    end
  end
end
