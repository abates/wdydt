require 'rails_helper'

RSpec.describe "activities/edit", type: :view do
  setup_activity_view

  before(:each) do
    @activity = assign(:activity, @activity_type1.activity_class.first)
  end

  it "renders the edit activity form" do
    render

    assert_select "form[action=?][method=?]", activity_path(@activity), "post" do
    end
  end
end
