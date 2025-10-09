module Admin
  class SpecialismController < ApplicationController
    layout "dashboard"

    def specialism_params
      params.permit(:name)
    end
    # Agrega aquí la lógica de tu controlador
    def index
      @nav_link = 'master-data'
      result = SpecialismService.fetch_all

      if result[:success]
        @specialisms = result[:data]
      else
        @specialisms = []
        flash.now[:alert] = result[:message]
      end

      render 'admin/specialism/index'
    end

    def new
      @nav_link = 'master-data'
      render 'admin/specialism/new'
    end

    def create
      resp = SpecialismService.create(specialism_params)
      if resp[:success]
        redirect_to "/admin/specialism/#{resp[:data].id}/edit", notice: resp[:message]
      else
        flash[:alert] = resp[:message]
        puts resp
        redirect_to "/admin/specialism/new"
      end
    end

    def edit
      @nav_link = 'master-data'
      specialism_id = params[:id]
      resp = SpecialismService.fetch_one(specialism_id)
      if resp[:success]
        @specialism = resp[:data]
        render 'admin/specialism/edit'
      else
        flash[:alert] = resp[:message]
        redirect_to "/admin/specialism/new"
      end
    end

    def update
      resp = SpecialismService.update(params[:id], specialism_params)
      
      if resp[:success]
        redirect_to "/admin/specialism/#{params[:id]}/edit", notice: resp[:message]
      else
        flash[:alert] = resp[:message]
        redirect_to "/admin/specialism/#{params[:id]}/edit"
      end
    end

    def delete
      resp = SpecialismService.delete(params[:id])
      
      if resp[:success]
        redirect_to "/admin/specialism", notice: resp[:message]
      else
        flash[:alert] = resp[:message]
        redirect_to "/admin/specialism"
      end
    end
  end
end

