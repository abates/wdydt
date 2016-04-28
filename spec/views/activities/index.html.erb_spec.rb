require 'rails_helper'

RSpec.describe "activities/index", type: :view do
  setup_activity_view

  before(:each) do
    assign(:activities, @activity_type1.activity_class.page(1))
  end

  it "renders a list of activities" do
    render
  end
end
