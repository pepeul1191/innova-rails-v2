module Admin
  class IndustryController < ApplicationController
    layout "dashboard"

    def industry_params
      params.permit(:name, :page, :per_page)
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
      result = IndustryService.fetch_all(page: page, per_page: per_page, search_query: search_query)

      if result[:success]
        @industries = result[:data][:industries]
        @pagination = result[:data][:pagination]
        @search_query = search_query
      else
        @industries = []
        @pagination = {
          page: page,
          per_page: per_page,
          total_industries: 0,
          total_pages: 0,
          start_record: 0,
          end_record: 0
        }
        @search_query = search_query
        flash.now[:alert] = result[:message]
      end

      render 'admin/industry/index'
    end

    def new
      @nav_link = 'master-data'
      render 'admin/industry/new'
    end

    def edit
      @nav_link = 'master-data'
      industry_id = params[:id]
      resp = IndustryService.fetch_one(industry_id)
      if resp[:success]
        @industry = resp[:data]
        render 'admin/industry/edit'
      else
        flash[:alert] = resp[:message]
        redirect_to "/admin/industry/new"
      end
    end

    def update
      resp = IndustryService.update(params[:id], industry_params)
      
      if resp[:success]
        redirect_to "/admin/industry/#{params[:id]}/edit", notice: resp[:message]
      else
        flash[:alert] = resp[:message]
        redirect_to "/admin/industry/#{params[:id]}/edit"
      end
    end

    def delete
      resp = IndustryService.delete(params[:id])
      
      if resp[:success]
        redirect_to "/admin/industry", notice: resp[:message]
      else
        flash[:alert] = resp[:message]
        redirect_to "/admin/industry"
      end
    end
  end
end

