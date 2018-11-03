class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token, if: -> { controller_name == "registrations" && action_name == 'create' }
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth, if: :production?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :avatar])
  end

  private
    def logged_in_user?
      current_user
    end

    def basic_auth
      authenticate_or_request_with_http_basic do |username, password|
        username == env["BASIC_AUTH_USER"] && password == env["BASIC_AUTH_PASSWORD"]
      end
    end

    def production?
      Rails.env.production?
    end
end
