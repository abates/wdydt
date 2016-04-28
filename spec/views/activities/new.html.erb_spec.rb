require 'rails_helper'

RSpec.describe "activities/new", type: :view do
  setup_activity_view

  before(:each) do
    assign(:activity, @activity_type1.activity_class.new)
  end

  it "renders new activity form" do
    render

    assert_select "form[action=?][method=?]", activities_path, "post" do
    end
  end
end
