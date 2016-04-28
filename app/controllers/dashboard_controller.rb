class DashboardController < AuthenticatedController
  include ActivitiesCrud
  before_action :set_activity_type, except: [ :index ]
  before_action :set_activity, except: [ :index, :new, :create ]

  def index
    @activity_types = ActivityType.all.order(:name)
    @todays_activities = Activity.all.where(day: Date.today)
  end
end
