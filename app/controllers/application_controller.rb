class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_custom_header

  private

  def set_custom_header
    response.set_header("Server", "Ubuntu")
  end
end
