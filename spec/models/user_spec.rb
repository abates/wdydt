require 'rails_helper'

RSpec.describe User, type: :model do
  it "provides a list of unused omniauth providers" do
    u = User.create
    u.identities << Identity.create(provider: "facebook")
    u.save

    expect(u.unused_providers).to match_array([:google_oauth2, :github])
  end
end
