require 'rails_helper'

RSpec.describe Identity, type: :model do
  it "creates an identity if one doesn't exist" do
    expect(Identity.all.count).to be(0)
    i = Identity.find_for_oauth OmniAuth.config.mock_auth[:facebook]
    expect(i).to be_persisted
  end
end
