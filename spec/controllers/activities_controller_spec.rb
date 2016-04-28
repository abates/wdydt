require 'rails_helper'

RSpec.describe ActivitiesController, type: :controller do
  login_user
  create_test_activities

  describe "GET #index" do
    it "assigns activities as @activities" do
      get :index, activity_type: @activity_type2.table_name
      expect(assigns(:activity_type)).to eq(@activity_type2)
      expect(assigns(:activities)).to eq(@activity_type2.activity_class.page(1))
    end
  end
end
