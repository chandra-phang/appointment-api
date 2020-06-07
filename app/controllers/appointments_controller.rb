class AppointmentsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_appointment, only: [:show, :update, :destroy]

  def index
    appointments = Appointment.all
    json_response(appointments)
  end

  def show
    json_response(@appointment)
  end

  def create
    appointment = Appointment.create!(appointment_params)
    json_response(appointment, :created)
  end

  def update
    @appointment.update(appointment_params)
    head :no_content
  end

  def destroy
    @appointment.destroy
    head :no_content
  end

  private

  def appointment_params
    params.permit(:patient_id, :doctor_id, :hospital_id, :start_at, :end_at)
  end

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end
end
