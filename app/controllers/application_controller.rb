class ApplicationController < ActionController::Base
  # # Habilita a autenticação no escopo inicial do projeto
  # before_action :authenticate_user!

  # # Permite parametros com valores especificos para cada escopo do devise
  # before_action :configure_permitted_parameters, if: :devise_controller?

  # # Desativa a proteção contra falsificação no controller, ignorando a verificação before_action:
  # skip_before_action :verify_authenticity_token

  # protected
  
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password])
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :current_password])
  # end
end
