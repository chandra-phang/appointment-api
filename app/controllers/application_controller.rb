class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  respond_to :json

  # before_action :authenticate_user!

  # private

  # def current_user
  #   @current_user ||= super || User.find_by(id: @current_user_id)
  # end

  # def signed_in?
  #   @current_user_id.present?
  # end
end
