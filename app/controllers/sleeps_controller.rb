class SleepsController < ApplicationController
  before_action :set_sleep, only: [:show, :edit, :update, :destroy]

  # GET /sleeps
  # GET /sleeps.json
    def index
        @sleeps = current_user.sleeps
        # @sleeps = Sleep.where(:user_id => current_user.id,:created_at => date_param)
        # @sleeps = Sleep.where(["created_at = ? AND user_id = ?",  date_param,current_user.id])
       # CourseOrder.where("ordered_at > ? AND ordered_at < ?", time - 1.day, time)
  # byebug
    end

    def sleeps_of_day
      date_param = params[:date_param]
      @sleeps_of_day = Sleep.where(["date(created_at) = ? AND user_id = ?", date_param,current_user.id])
    
    end




  # GET /sleeps/1
  # GET /sleeps/1.json
  def show
      unless current_user.nil?
          @motions = @sleep.motions
      end
  end

  # GET /sleeps/new
  def new
    @sleep = Sleep.new
  end

  # GET /sleeps/1/edit
  def edit
  end

  # POST /sleeps
  # POST /sleeps.json
  def create
    @sleep = Sleep.new(sleep_params)
    @sleep.user_id = current_user.id;
    respond_to do |format|
      if @sleep.save
        format.html { redirect_to @sleep, notice: 'Sleep was successfully created.' }
        format.json { render :show, status: :created, location: @sleep }
      else
        format.html { render :new }
        format.json { render json: @sleep.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sleeps/1
  # PATCH/PUT /sleeps/1.json
  def update
    respond_to do |format|
      if @sleep.update(sleep_params)
        format.html { redirect_to @sleep, notice: 'Sleep was successfully updated.' }
        format.json { render :show, status: :ok, location: @sleep }
      else
        format.html { render :edit }
        format.json { render json: @sleep.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sleeps/1
  # DELETE /sleeps/1.json
  def destroy
    @sleep.destroy
    respond_to do |format|
      format.html { redirect_to sleeps_url, notice: 'Sleep was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sleep
      @sleep = Sleep.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sleep_params
      params.require(:sleep).permit(:user_id, :start_time, :end_time)
    end


end
