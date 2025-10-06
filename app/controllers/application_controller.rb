class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_custom_header
  before_action :require_login

  private

  def set_custom_header
    response.set_header("Server", "Ubuntu")
  end

  def require_login
    puts "login!!!!!!!!!!!!!"
    unless logged_in?
      flash[:alert] = "Debes iniciar sesión para acceder a esta página"
      redirect_to sign_in_path
    end
  end

  def logged_in?
    # Verifica si hay un usuario en sesión
    session[:user_id].present?
  end
end
