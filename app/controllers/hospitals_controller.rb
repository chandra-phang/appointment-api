class HospitalsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_hospitals, only: [:show, :update, :destroy]

  def index
    hospitals = Hospital.active.all
    json_response(hospitals)
  end

  def show
    json_response(@hospital)
  end

  def create
    hospital = Hospital.create!(hospital_params)
    hospital.update(state: "active")
    json_response(hospital, :created)
  end

  def update
    @hospital.update(hospital_params)
    head :no_content
  end

  def destroy
    @hospital.update(state: :deleted)
    head :no_content
  end

  private

  def hospital_params
    params.permit(:name, :address)
  end

  def set_hospitals
    @hospital = Hospital.find_by!(id: params[:id], state: :active)
  end
end
