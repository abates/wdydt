require "rails_helper"

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  describe "callback" do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    context "with valid login" do
      before :each do
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
      end

      it "creates a non-existant user" do
        expect {
          get :facebook
        }.to change(User, :count).by(1)
      end

      context "and confirmed email" do
        before :each do
          get :facebook
          identity = Identity.find_for_oauth(OmniAuth.config.mock_auth[:facebook])
          identity.user.confirmed_at = Time.now
          identity.user.save!
        end

        it "redirects to the dashboard" do
          get :facebook
          expect(response).to redirect_to(root_url)
        end

        it "sets the current_user" do
          get :facebook
          expect(controller.current_user).to_not be(nil)
        end
      end
    end

    context "with successful login and missing data" do
      before :each do
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook_without_email]
      end

      it "redirects to the new user page" do
        get :facebook
        expect(request).to redirect_to(new_user_registration_url)
      end

      it "sets the flash alert to the error message" do
        get :facebook
        expect(flash[:alert]).to_not be(nil)
      end
    end
  end
end
