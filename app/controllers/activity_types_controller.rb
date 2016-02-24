class ActivityTypesController < AuthenticatedController
  include ActivitiesCrud
  before_action :set_activity_type
  before_action :set_activity, except: [ :index, :new, :create ]

  # GET /activities
  # GET /activities.json
  def index
    @activities = @activity_type.page(params[:page])
  end
end
