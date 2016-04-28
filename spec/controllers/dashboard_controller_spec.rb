require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  login_user
  create_test_activities

  describe "GET #index" do
    it "assigns all of today's activities as @todays_activities" do
      todays_activities = Activity.all.where(day: Date.today)

      get :index
      expect(assigns(:activity_types)).to eq([@activity_type1, @activity_type2])
      expect(assigns(:todays_activities)).to eq(todays_activities)
    end
  end
end

