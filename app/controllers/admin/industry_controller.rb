module Admin
  class IndustryController < ApplicationController
    layout "dashboard"

    def industry_params
      params.permit(:name)
    end
    # Agrega aquí la lógica de tu controlador
    def index
      @nav_link = 'master-data'
      result = IndustryService.fetch_all

      if result[:success]
        @industries = result[:data]
      else
        @industries = []
        flash.now[:alert] = result[:message]
      end

      render 'admin/industry/index'
    end

    def new
      @nav_link = 'master-data'
      render 'admin/industry/new'
    end

    def create
      resp = IndustryService.create(industry_params)
      if resp[:success]
        redirect_to "/admin/industry/#{resp[:data].id}/edit", notice: resp[:message]
      else
        flash[:alert] = resp[:message]
        puts resp
        redirect_to "/admin/industry/new"
      end
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

