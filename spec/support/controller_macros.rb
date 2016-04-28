module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      sign_in :user, user
    end
  end

  def resource_class
    User
  end
end

RSpec.configure do |config|
  config.extend ControllerMacros, :type => :controller
end
