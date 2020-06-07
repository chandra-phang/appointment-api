class DoctorSchedulesController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_doctor
  before_action :set_doctor_schedule, only: [:show, :update, :destroy]

  def index
    json_response(@doctor.doctor_schedules)
  end

  def show
    json_response(@schedule)
  end

  def create
    @doctor.doctor_schedules.create!(schedule_params)
    json_response(@doctor, :created)
  end

  def update
    @schedule.update(schedule_params)
    head :no_content
  end

  def destroy
    @schedule.destroy
    head :no_content
  end

  private

  def schedule_params
    params.permit(:hospital_id, :doctor_id, :start_time, :end_time, day_of_week: [])
  end

  def set_doctor
    @doctor = User.find_by!(id: params[:doctor_id], role: :doctor)
  end

  def set_doctor_schedule
    @schedule = @doctor.doctor_schedules.find_by!(id: params[:id]) if @doctor
  end
end
