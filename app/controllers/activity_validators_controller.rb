class ActivityValidatorsController < ApplicationController
  before_action :set_activity_validator, only: [:show, :edit, :update, :destroy]

  # GET /activity_validators
  # GET /activity_validators.json
  def index
    @activity_validators = ActivityValidator.all
  end

  # GET /activity_validators/1
  # GET /activity_validators/1.json
  def show
  end

  # GET /activity_validators/new
  def new
    @activity_validator = ActivityValidator.new
  end

  # GET /activity_validators/1/edit
  def edit
  end

  # POST /activity_validators
  # POST /activity_validators.json
  def create
    @activity_validator = ActivityValidator.new(activity_validator_params)

    respond_to do |format|
      if @activity_validator.save
        format.html { redirect_to @activity_validator, notice: 'Activity validator was successfully created.' }
        format.json { render :show, status: :created, location: @activity_validator }
      else
        format.html { render :new }
        format.json { render json: @activity_validator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activity_validators/1
  # PATCH/PUT /activity_validators/1.json
  def update
    respond_to do |format|
      if @activity_validator.update(activity_validator_params)
        format.html { redirect_to @activity_validator, notice: 'Activity validator was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity_validator }
      else
        format.html { render :edit }
        format.json { render json: @activity_validator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activity_validators/1
  # DELETE /activity_validators/1.json
  def destroy
    @activity_validator.destroy
    respond_to do |format|
      format.html { redirect_to activity_validators_url, notice: 'Activity validator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity_validator
      @activity_validator = ActivityValidator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_validator_params
      params.require(:activity_validator).permit(:activity_type_id, :activity_field_id, :description, :formula, :message)
    end
end
