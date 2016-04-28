require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    include HelperMacros
    def index
      render nothing: true
    end

    def devise_controller?
      true
    end
  end

  describe "devise parameter sanitizer" do
    it "should add name to sign_up and account_update parameters" do
      get(:index)
      expect(controller.devise_parameter_sanitizer.for(:sign_up)).to include(:name)
      expect(controller.devise_parameter_sanitizer.for(:account_update)).to include(:name)
    end
  end
end
