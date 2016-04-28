require "rails_helper"

RSpec.describe ActivitiesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/activities/foo").to route_to("activities#index", activity_type: "foo")
    end

    it "routes to #new" do
      expect(get: "/activities/foo/new").to route_to("activities#new", activity_type: "foo")
    end

    it "routes to #show" do
      expect(get: "/activities/foo/1").to route_to("activities#show", activity_type: "foo", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/activities/foo/1/edit").to route_to("activities#edit", activity_type: "foo", id: "1")
    end

    it "routes to #create" do
      expect(post: "/activities/foo").to route_to("activities#create", activity_type: "foo")
    end

    it "routes to #update via PUT" do
      expect(put: "/activities/foo/1").to route_to("activities#update", activity_type: "foo", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/activities/foo/1").to route_to("activities#update", activity_type: "foo", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/activities/foo/1").to route_to("activities#destroy", activity_type: "foo", id: "1")
    end

  end
end
