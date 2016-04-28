require "rails_helper"

RSpec.describe ActivityValidatorsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/activity_validators").to route_to("activity_validators#index")
    end

    it "routes to #new" do
      expect(:get => "/activity_validators/new").to route_to("activity_validators#new")
    end

    it "routes to #show" do
      expect(:get => "/activity_validators/1").to route_to("activity_validators#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/activity_validators/1/edit").to route_to("activity_validators#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/activity_validators").to route_to("activity_validators#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/activity_validators/1").to route_to("activity_validators#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/activity_validators/1").to route_to("activity_validators#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/activity_validators/1").to route_to("activity_validators#destroy", :id => "1")
    end

  end
end
