require 'rails_helper'

RSpec.describe "activity_validators/index", type: :view do
  before(:each) do
    assign(:activity_validators, [
      ActivityValidator.create!(
        :activity_type => nil,
        :activity_field => nil,
        :description => "MyText",
        :formula => "MyText",
        :message => "MyText"
      ),
      ActivityValidator.create!(
        :activity_type => nil,
        :activity_field => nil,
        :description => "MyText",
        :formula => "MyText",
        :message => "MyText"
      )
    ])
  end

  it "renders a list of activity_validators" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 4
    assert_select "tr>td", :text => "MyText".to_s, :count => 6
  end
end
