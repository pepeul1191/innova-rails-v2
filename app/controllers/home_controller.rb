# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
    # Tu lógica aquí
    @welcome_message = "Bienvenido a mi aplicación"
  end
end