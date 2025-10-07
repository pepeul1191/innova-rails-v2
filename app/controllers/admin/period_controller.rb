module Admin
  class PeriodController < ApplicationController
    layout "dashboard"
    # Agrega aquí la lógica de tu controlador
    def index
      @nav_link = 'master-data'
      # Tu código aquí
    end
  end
end