module Admin
  class ProgramTypeController < ApplicationController
    layout "dashboard"

    def period_params
      params.permit(:name, :init_date, :end_date)
    end
    # Agrega aquí la lógica de tu controlador
    def index
      @nav_link = 'master-data'
      
      # Obtener parámetros de la URL
      page = params[:page]&.to_i || 1
      per_page = params[:per_page]&.to_i || 10
      search_query = params[:name]

      # Validar que no sean valores negativos o cero
      page = 1 if page < 1
      per_page = 10 if per_page < 1

      # Llamar al servicio con paginación
      result = ProgramTypeService.fetch_all(page: page, per_page: per_page, search_query: search_query)

      if result[:success]
        @program_types = result[:data][:program_types]
        @pagination = result[:data][:pagination]
        @search_query = search_query
      else
        @program_types = []
        @pagination = {
          page: page,
          per_page: per_page,
          total_program_types: 0,
          total_pages: 0,
          start_record: 0,
          end_record: 0
        }
        @search_query = search_query
        flash.now[:alert] = result[:message]
      end

      render 'admin/program_type/index'
    end


    def new
      @nav_link = 'master-data'
      render 'admin/program_type/new'
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
        render 'admin/program_type/edit'
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

