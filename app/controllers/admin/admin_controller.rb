module Admin
  class AdminController < ApplicationController
    layout "dashboard"
    # Agrega aquí la lógica de tu controlador
    def master_data
      @nav_link = 'master-data'
      # Tu código aquí
      render 'admin/admin/master_data'
    end
  end
end