class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
        rescue_from ActiveRecord::RecordNotUnique, :with => :error_render_method

  before_action :configure_permitted_parameters, if: :devise_controller?

  def error_render_method
    render json: { errors: {full_messages: ["Please choose another Username"]}}, status: 401
  end

  protected

  def configure_permitted_parameters
    Rails.logger.info "in ApplicationController.rb configure_permitted_parameters!"
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
end