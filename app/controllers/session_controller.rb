# app/controllers/session_controller.rb
class SessionController < ApplicationController
  layout "blank"
  before_action :redirect_if_logged_in, only:[:login]

  def sign_in
    
  end

  def login
    username = params[:username]
    password = params[:password]

    stored_username = ENV['USERNAME']
    stored_password = ENV['PASSWORD']

    if username == stored_username && password == stored_password      
      session[:user_id] = username 
      flash[:notice] = "Login exitoso"
      redirect_to root_path 
    else
      flash[:alert] = "Usuario o contraseña incorrectos"
      render :sign_in 
    end
  end

   def sign_out
    session[:user_id] = nil
    flash[:notice] = "Sesión cerrada correctamente"
    redirect_to sign_in_path
  end
end