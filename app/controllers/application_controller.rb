class ApplicationController < ActionController::API
  include Pundit::Authorization
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotUnique, :with => :error_render_method
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  def not_authorized 
    render json: { error: 'errors.not_authorized' }, status: 404
  end 
  

  def error_render_method
    render json: { errors: {full_messages: ["Please choose another Username"]}}, status: 401
  end

  protected

  def configure_permitted_parameters
    Rails.logger.info "in ApplicationController.rb configure_permitted_parameters!"
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
end