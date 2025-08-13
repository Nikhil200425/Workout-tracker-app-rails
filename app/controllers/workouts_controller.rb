require "csv"
class WorkoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_workout, only: %i[ show edit update destroy]

  # GET /workouts or /workouts.json
  def index
    if params[:query].present?
      @workouts = current_user.workouts.search_by_title_and_description(params[:query])
    else
      @workouts = current_user.workouts
    end
  end
  # GET /workouts/1 or /workouts/1.json
  def show
  end

  # GET /workouts/new
  def new
    @workout = current_user.workouts.build
  end

  # GET /workouts/1/edit
  def edit
  end

  # POST /workouts or /workouts.json
  def create
    @workout = current_user.workouts.build(workout_params)

    respond_to do |format|
      if @workout.save
        format.html { redirect_to @workout, notice: "Workout was successfully created." }
        format.json { render :show, status: :created, location: @workout }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workouts/1 or /workouts/1.json
  def update
    respond_to do |format|
      if @workout.update(workout_params)
        format.html { redirect_to @workout, notice: "Workout was successfully updated." }
        format.json { render :show, status: :ok, location: @workout }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workouts/1 or /workouts/1.json
  def destroy
    @workout.destroy!

    respond_to do |format|
      format.html { redirect_to workouts_path, status: :see_other, notice: "Workout was successfully destroyed." }
      format.json { head :no_content }
    end
  end

   def download_workouts
    workouts = current_user.workouts
    csv_data = CSV.generate(headers: true) do |csv|
      csv << [ "Title", "Start Time", "End Time" ]
      workouts.each do |w|
        csv << [ w.title, w.start_time, w.end_time ]
      end
    end
    send_data csv_data, filename: "workouts.csv"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workout
      @workout = Workout.find(params[:id])
    end

    def workout_params
      params.require(:workout).permit(:title, :description, :start_time, :end_time, :user_id)
    end
end
