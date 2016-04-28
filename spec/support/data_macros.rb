module DataMacros
  def create_test_activities
    before :each do
      @activity_type1 = ActivityType.create(name: "First Activity")
      @activity_type1.fields << ActivityField.create(name: "name", field_type: "string")
      @activity_type1.validators << ActivityValidator.create(message: "name can't be blank", activity_field: @activity_type1.fields[0], formula: "name != ''")
      @activity_type2 = ActivityType.create(name: "Second Activity")

      @activities = []
      @activities << @activity_type1.activity_class.create(day: Date.today, name: "foo")
      @activities << @activity_type2.activity_class.create(day: Date.today)
      @activities << @activity_type2.activity_class.create(day: Date.today)
      @activities << @activity_type2.activity_class.create(day: Date.today - 1)
      @activities << @activity_type1.activity_class.create(day: Date.today - 2, name: "bar")
    end
  end
end

RSpec.configure do |config|
  config.extend DataMacros
end
