class ActivitiesController < AuthenticatedController
  include ActivitiesCrud
  before_action :set_activity_type, only: [:new, :edit, :update, :create]
  before_action :set_activity, except: [ :index, :new, :create ]

  def index
    @activities = ActivityPlugin.all.values
    @today = Activity.all.where(day: Date.today)
  end
end
