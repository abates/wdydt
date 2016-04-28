require 'rails_helper'

RSpec.describe "activity_validators/new", type: :view do
  before(:each) do
    assign(:activity_validator, ActivityValidator.new(
      :activity_type => nil,
      :activity_field => nil,
      :description => "MyText",
      :formula => "MyText",
      :message => "MyText"
    ))
  end

  it "renders new activity_validator form" do
    render

    assert_select "form[action=?][method=?]", activity_validators_path, "post" do

      assert_select "input#activity_validator_activity_type_id[name=?]", "activity_validator[activity_type_id]"

      assert_select "input#activity_validator_activity_field_id[name=?]", "activity_validator[activity_field_id]"

      assert_select "textarea#activity_validator_description[name=?]", "activity_validator[description]"

      assert_select "textarea#activity_validator_formula[name=?]", "activity_validator[formula]"

      assert_select "textarea#activity_validator_message[name=?]", "activity_validator[message]"
    end
  end
end
