class UsersController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.active.all
    json_response(@users)
  end

  def show
    json_response(@user)
  end

  def create
    @user = User.create!(user_params)
    @user.update(state: :active)
    if user_params[:hostpital_id] && @user.doctor?
      hospital = Hospital.find(user_params[:hostpital_id])
      @user.hospital_affiliations.create(hospital: hospital)
    end
    json_response(@user, :created)
  end

  def update
    @user.update(user_params)
    head :no_content
  end

  def destroy
    @user.update(state: :deleted)
    head :no_content
  end

  private

  def service
    UserService.new(nil)
  end

  def user_params
    params.permit(:name, :email, :password, :role, :gender, :date_of_birth, :hostpital_id)
  end

  def set_user
    @user = User.find_by!(id: params[:id], role: params[:role], state: :active)
  end
end
