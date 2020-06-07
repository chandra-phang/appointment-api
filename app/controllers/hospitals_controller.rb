class HospitalsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_hospitals, only: [:show, :update, :destroy]

  def index
    @hospitalss = Hospital.active.all
    json_response(@hospitalss)
  end

  def show
    json_response(@hospitals)
  end

  def create
    @hospitals = Hospital.create!(hospital_params)
    @hospitals.update(state: "active")
    json_response(@hospitals, :created)
  end

  def update
    @hospitals.update(hospital_params)
    head :no_content
  end

  def destroy
    @hospitals.update(state: :deleted)
    head :no_content
  end

  private

  def hospital_params
    params.permit(:name, :address)
  end

  def set_hospitals
    @hospitals = Hospital.find_by!(id: params[:id], state: :active)
  end
end
