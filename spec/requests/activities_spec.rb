require 'rails_helper'

RSpec.describe "Activities", type: :request do
  describe "GET /activities" do
    it "does something" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end
end
