require 'rails_helper'

RSpec.describe ActivityValidator, type: :model do
  context "with invalid formula" do
    before :each do
      @v = ActivityValidator.new(formula: "1==")
    end

    it "marks the model invalid if the formula cannot be parsed" do
      expect(@v).to be_invalid
    end

    it "sets an error message on the formula field" do
      @v.validate
      expect(@v.errors[:formula]).to_not be_empty
    end
  end

  context "with activity_type" do
    before :each do
      @activity_type = ActivityType.create(name: "Validatable Activity")
      @activity_type.fields << ActivityField.create(name: "name", field_type: "string")
      @activity_type.validators << ActivityValidator.create(message: "name can't be blank", activity_field: @activity_type.fields[0], formula: "name != ''")
      @activity_validator = @activity_type.validators[0]
    end

    context "with invalid data" do
      it "can validate an activity with invalid data" do
        activity = @activity_type.activity_class.new(name: "")
        expect(@activity_validator.evaluate(activity)).to be(false)
      end
    end

    context "with valid data" do
      it "can validate an activity" do
        activity = @activity_type.activity_class.new(name: "foo")
        expect(@activity_validator.evaluate(activity)).to be(true)
      end
    end
  end
end
