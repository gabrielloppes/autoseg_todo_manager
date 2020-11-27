class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  skip_before_action :verify_authenticity_token

  protected

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :current_password])
  end
  
  def favorite_text
    # Mudará o estado se o favorito existir
    return @favorite_exists ? "Unfavorite" : "Favorite"
  end

  helper_method :favorite_text
end
