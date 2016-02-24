class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :devise_parameters, if: :devise_controller?

  protected
    def devise_parameters
      devise_parameter_sanitizer.for(:sign_up) << :name
      devise_parameter_sanitizer.for(:account_update) << :name
    end
end
