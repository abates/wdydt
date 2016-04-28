require 'rails_helper'

RSpec.describe "activity_validators/show", type: :view do
  before(:each) do
    @activity_validator = assign(:activity_validator, ActivityValidator.create!(
      :activity_type => nil,
      :activity_field => nil,
      :description => "MyText",
      :formula => "MyText",
      :message => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
