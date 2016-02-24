require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the DeviseHelper. For example:
#
# describe DeviseHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe DeviseHelper, type: :helper do
  describe "provider_name" do
    it "converts a provider symbol to a string recognized in Font Awesome" do
      expect(provider_name(:google_oauth2)).to eq("google")
      expect(provider_name(:facebook)).to eq("facebook")
    end
  end

  describe "social icon" do
    it "produces a div that is styled for an omniauth provider" do
      div = social_icon(:facebook)
      expect(div).to have_tag("div", with: { class: [ "btn", "btn-social-icon", "btn-facebook" ] })
      expect(div).to have_tag("span", with: { class: [ "fa", "fa-facebook" ] })
    end
  end

  describe "social link" do
    it "produces an a that is styled for an omniauth provider login" do
      href = link_to_social_login(:facebook)
      expect(href).to have_tag("a", with: { class: [ "btn", "btn-social-icon", "btn-facebook" ] })
      expect(href).to have_tag("span", with: { class: [ "fa", "fa-facebook" ] })
    end
  end
end
