require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  describe "updating a user" do
    login_user

    it "doesn't require a password" do
      post :update, { id: controller.current_user.id, user: { name: "name" } }
      expect(response).to redirect_to(root_url)
    end 
  end
end
