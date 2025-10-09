# app/services/document_type_service.rb
class IndustryService < ApplicationService
  def self.fetch_all
    industries = Industry.all.order(name: :asc)
    build_response(data: industries, message: "Lista de industrias obtenida exitosamente")
  rescue => e
    handle_error("Error al obtener las industrias: #{e.message}", e.backtrace)
  end

  def self.fetch_one(id)
    industry = Industry.find_by(id: id)
    return handle_not_found("Industria no encontrado") unless industry
    
    build_response(data: industry, message: "Industria encontrado")
  rescue => e
    handle_error("Error al buscar el industria: #{e.message}", e.backtrace)
  end

  def self.create(params)
    industry = Industry.new(params)
    if industry.save
      build_response(data: industry, message: "Industria creado exitosamente")
    else
      handle_validation_error(industry)
    end
  rescue => e
    handle_error("Error al crear industria: #{e.message}", e.backtrace)
  end

  def self.update(id, params)
    industry = Industry.find_by(id: id)
    return handle_not_found("Industria no encontrado") unless industry

    if industry.update(params)
      build_response(data: industry, message: "Industria actualizado exitosamente")
    else
      handle_validation_error(industry)
    end
  rescue => e
    handle_error("Error al actualizar industria: #{e.message}", e.backtrace)
  end

  def self.delete(id)
    industry = Industry.find_by(id: id)
    return handle_not_found("Industria no encontrado") unless industry

    if industry.destroy
      build_response(message: "Industria eliminado exitosamente")
    else
      handle_error("No se pudo eliminar el industria")
    end
  rescue => e
    handle_error("Error al eliminar industria: #{e.message}", e.backtrace)
  end
end