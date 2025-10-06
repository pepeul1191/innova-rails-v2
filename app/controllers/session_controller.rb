# app/controllers/session_controller.rb
class SessionController < ApplicationController
  skip_before_action :require_login, only: [:sign_in]

  def sign_in
    
  end
end