require 'rails_helper'

RSpec.describe "ActivityValidators", type: :request do
  describe "GET /activity_validators" do
    it "works! (now write some real specs)" do
      get activity_validators_path
      expect(response).to have_http_status(200)
    end
  end
end
