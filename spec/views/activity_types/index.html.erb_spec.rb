require 'rails_helper'

RSpec.describe "activity_types/index", type: :view do
  before(:each) do
    assign(:activity_types, [
      ActivityType.create!(),
      ActivityType.create!()
    ])
  end

  it "renders a list of activity_types" do
    render
  end
end
