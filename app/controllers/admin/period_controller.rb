module Admin
  class PeriodController < ApplicationController
    layout "dashboard"

    def period_params
      params.permit(:name, :init_date, :end_date)
    end
    # Agrega aquí la lógica de tu controlador
    def index
      @nav_link = 'master-data'
      result = PeriodService.fetch_all

      if result[:success]
        @periods = result[:data]
      else
        @periods = []
        flash.now[:alert] = result[:message]
      end
    end

    def new
      @nav_link = 'master-data'
    end

    def create
      resp = PeriodService.create(period_params)
      if resp[:success]
        redirect_to "/admin/period/#{resp[:data].id}/edit", notice: resp[:message]
      else
        flash[:alert] = resp[:message]
        puts resp
        redirect_to "/admin/period/new"
      end
    end

    def edit
      @nav_link = 'master-data'
      period_id = params[:id]
      resp = PeriodService.fetch_one(period_id)
      if resp[:success]
        @period = resp[:data]
      else
        flash[:alert] = resp[:message]
        redirect_to "/admin/period/new"
      end
    end

    def update
      resp = PeriodService.update(params[:id], period_params)
      
      if resp[:success]
        redirect_to "/admin/period/#{params[:id]}/edit", notice: resp[:message]
      else
        flash[:alert] = resp[:message]
        redirect_to "/admin/period/#{params[:id]}/edit"
      end
    end

    def delete
      resp = PeriodService.delete(params[:id])
      
      if resp[:success]
        redirect_to "/admin/period", notice: resp[:message]
      else
        flash[:alert] = resp[:message]
        redirect_to "/admin/period"
      end
    end
  end
end

