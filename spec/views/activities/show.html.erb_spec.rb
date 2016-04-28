require 'rails_helper'

RSpec.describe "activities/show", type: :view do
  setup_activity_view

  before(:each) do
    assign(:activity, @activity_type1.activity_class.last)
  end

  it "renders attributes in <p>" do
    render
  end
end
