require 'rails_helper'

RSpec.describe ActivitiesCrud, type: :controller do
  template_class = Class.new do
    def initialize template_name
      @template_name = template_name
    end

    def render *args
      ActiveSupport::Notifications.instrument("!render_template.action_view", { virtual_path: @template_name })
      ""
    end

    def identifier
      @template_name
    end

    def formats
      [ :html ]
    end
  end

  controller(AuthenticatedController) do
    include ActivitiesCrud
    before_action :set_activity_type
    before_action :set_activity, except: [ :index, :new, :create ]

    define_method :_render_template do |options|
      options[:template] = template_class.new(options[:template])
      super options
    end
  end

  login_user
  create_test_activities

  let(:type1_valid_attributes) do
    { name: "foo" }
  end

  let(:type1_invalid_attributes) do
    { name: "" }
  end

  describe "GET #new" do
    it "assigns a new activity as @activity" do
      get :new, { activity_type: @activity_type1.table_name }
      expect(assigns(:activity)).to be_a_new(@activity_type1.activity_class)
    end
  end

  describe "GET #edit" do
    it "assigns the requested activity as @activity" do
      get :edit, {activity_type: @activity_type1.table_name, :id => @activities[0].id}
      expect(assigns(:activity)).to eq(@activities[0])
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Activity" do
        expect {
          post :create, {activity_type: @activity_type1.table_name, @activity_type1.activity_class.name.underscore => type1_valid_attributes}
        }.to change(@activity_type1.activity_class, :count).by(1)
      end

      it "assigns a newly created activity as @activity" do
        post :create, {activity_type: @activity_type1.table_name, @activity_type1.activity_class.name.underscore => type1_valid_attributes}
        expect(assigns(:activity)).to be_a(@activity_type1.activity_class)
        expect(assigns(:activity)).to be_persisted
      end

      it "redirects to the created activity" do
        post :create, {activity_type: @activity_type1.table_name, @activity_type1.activity_class.name.underscore => type1_valid_attributes}
        expect(response).to redirect_to(activities_path(@activity_type1.table_name, @activity_type1.activity_class.last))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved activity as @activity" do
        post :create, {activity_type: @activity_type1.table_name, @activity_type1.activity_class.name.underscore => type1_invalid_attributes}
        expect(assigns(:activity)).to be_a_new(@activity_type1.activity_class)
        expect(assigns(:activity)).not_to be_persisted
      end

      it "re-renders the 'new' template" do
        post :create, {activity_type: @activity_type1.table_name, @activity_type1.activity_class.name.underscore => type1_invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: "bar" }
      }

      it "updates the requested activity" do
        activity = @activity_type1.activity_class.create! type1_valid_attributes
        put :update, {activity_type: @activity_type1.table_name, id: activity.id, @activity_type1.activity_class.name.underscore => new_attributes}
        activity.reload
        expect(activity.name).to eq("bar")
      end

      it "assigns the requested activity as @activity" do
        activity = @activity_type1.activity_class.create! type1_valid_attributes
        put :update, {activity_type: @activity_type1.table_name, id: activity.to_param, @activity_type1.activity_class.name.underscore => new_attributes}
        activity.reload
        expect(assigns(:activity)).to eq(activity)
      end

      it "redirects to the activity" do
        activity = @activity_type1.activity_class.create! type1_valid_attributes
        put :update, {activity_type: @activity_type1.table_name, id: activity.to_param, @activity_type1.activity_class.name.underscore => new_attributes}
        expect(response).to redirect_to(activities_path(@activity_type1.table_name, activity.id))
      end
    end

    context "with invalid params" do
      it "assigns the activity as @activity" do
        activity = @activity_type1.activity_class.create! type1_valid_attributes
        put :update, {activity_type: @activity_type1.table_name, id: activity.id, @activity_type1.activity_class.name.underscore => type1_invalid_attributes}
        expect(assigns(:activity)).to eq(activity)
      end

      it "re-renders the 'edit' template" do
        activity = @activity_type1.activity_class.create! type1_valid_attributes
        put :update, {activity_type: @activity_type1.table_name, id: activity.id, @activity_type1.activity_class.name.underscore => type1_invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested activity" do
      activity = @activity_type1.activity_class.create! type1_valid_attributes
      expect {
        delete :destroy, {activity_type: @activity_type1.table_name, id: activity.id}
      }.to change(Activity, :count).by(-1)
    end

    it "redirects to the activities list" do
      activity = @activity_type1.activity_class.create! type1_valid_attributes
      delete :destroy, {activity_type: @activity_type1.table_name, id: activity.id}
      expect(response).to redirect_to(activities_path(@activity_type1.table_name))
    end
  end
end
