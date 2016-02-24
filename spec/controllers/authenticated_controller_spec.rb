require 'rails_helper'

RSpec.describe AuthenticatedController, type: :controller do
  login_user

  describe "before_filters" do
    controller AuthenticatedController do
      def index
        render :nothing => true
      end
    end
    it "sets the beginning of the week" do

      expect(Date.beginning_of_week).to equal(:monday)
      get :index
      expect(Date.beginning_of_week).to equal(:sunday)
    end
  end
end
