module Admin
  class ProgramTypeController < ApplicationController
    layout "dashboard"

    def period_params
      params.permit(:name, :init_date, :end_date)
    end
    # Agrega aquí la lógica de tu controlador
    def index
      @nav_link = 'master-data'
      result = ProgramTypeService.fetch_all

      if result[:success]
        @program_types = result[:data]
      else
        @program_types = []
        flash.now[:alert] = result[:message]
      end
    end

    def new
      @nav_link = 'master-data'
    end

    def create
      resp = ProgramTypeService.create(period_params)
      if resp[:success]
        redirect_to "/admin/program-type/#{resp[:data].id}/edit", notice: resp[:message]
      else
        flash[:alert] = resp[:message]
        puts resp
        redirect_to "/admin/program-type/new"
      end
    end

    def edit
      @nav_link = 'master-data'
      program_type_id = params[:id]
      resp = ProgramTypeService.fetch_one(program_type_id)
      if resp[:success]
        @program_type = resp[:data]
      else
        flash[:alert] = resp[:message]
        redirect_to "/admin/program-type/new"
      end
    end

    def update
      resp = ProgramTypeService.update(params[:id], period_params)
      
      if resp[:success]
        redirect_to "/admin/program-type/#{params[:id]}/edit", notice: resp[:message]
      else
        flash[:alert] = resp[:message]
        redirect_to "/admin/program-type/#{params[:id]}/edit"
      end
    end

    def delete
      resp = ProgramTypeService.delete(params[:id])
      
      if resp[:success]
        redirect_to "/admin/program-type", notice: resp[:message]
      else
        flash[:alert] = resp[:message]
        redirect_to "/admin/program-type"
      end
    end
  end
end

