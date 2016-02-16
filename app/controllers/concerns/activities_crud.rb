module ActivitiesCrud
  extend ActiveSupport::Concern

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = @activity_type.new
  end

  # GET /activities/1/edit
  def edit
  end
  
  # POST /activities
  # POST /activities.json
  def create
    @activity = @activity_type.new(activity_params)

    respond_to do |format|
      if @activity.save
        format.html { redirect_to activities_path(@activity_type.activity_type), notice: "#{@activity_type.name.humanize} was successfully created." }
        format.json { render :show, status: :created, location: @activity }
        format.js { render :update }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to activities_path(@activity_type.activity_type), notice: "#{@activity_type.name.humanize} was successfully updated." }
        format.json { render :show, status: :ok, location: @activity }
        format.js { render :update }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
        format.js { render :edit }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_path(@activity_type.activity_type), notice: "#{@activity_type.name.humanize} was successfully deleted." }
      format.json { head :no_content }
      format.js { render :update }
    end
  end

  def url_options
    if @activity_type.nil?
      {}
    else
      { activity_type: @activity_type.name.tableize }
    end
  end

  def set_activity
    @activity = @activity_type.find(params[:id])
  end

  def set_activity_type
    @activity_type = ActivityPlugin.find(params[:activity_type])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def activity_params
    params.require(@activity_type.name.underscore).permit(@activity_type.activity_form_fields)
  end
end
