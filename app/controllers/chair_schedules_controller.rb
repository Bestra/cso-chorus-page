class ChairSchedulesController < ApplicationController
  # GET /chair_schedules
  # GET /chair_schedules.json
  def index
    @chair_schedules = ChairSchedule.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chair_schedules }
    end
  end

  # GET /chair_schedules/1
  # GET /chair_schedules/1.json
  def show
    @chair_schedule = ChairSchedule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chair_schedule }
    end
  end

  # GET /chair_schedules/new
  # GET /chair_schedules/new.json
  def new
    @chair_schedule = ChairSchedule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chair_schedule }
    end
  end

  # GET /chair_schedules/1/edit
  def edit
    @chair_schedule = ChairSchedule.find(params[:id])
  end

  # POST /chair_schedules
  # POST /chair_schedules.json
  def create
    @chair_schedule = ChairSchedule.new(params[:chair_schedule])

    respond_to do |format|
      if @chair_schedule.save
        format.html { redirect_to @chair_schedule, notice: 'Chair schedule was successfully created.' }
        format.json { render json: @chair_schedule, status: :created, location: @chair_schedule }
      else
        format.html { render action: "new" }
        format.json { render json: @chair_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /chair_schedules/1
  # PUT /chair_schedules/1.json
  def update
    @chair_schedule = ChairSchedule.find(params[:id])

    respond_to do |format|
      if @chair_schedule.update_attributes(params[:chair_schedule])
        format.html { redirect_to @chair_schedule, notice: 'Chair schedule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @chair_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chair_schedules/1
  # DELETE /chair_schedules/1.json
  def destroy
    @chair_schedule = ChairSchedule.find(params[:id])
    @chair_schedule.destroy

    respond_to do |format|
      format.html { redirect_to chair_schedules_url }
      format.json { head :no_content }
    end
  end
end
