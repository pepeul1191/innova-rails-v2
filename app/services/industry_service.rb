# app/services/document_type_service.rb
class IndustryService < ApplicationService
  def self.fetch_all(page: 1, per_page: 10, search_query: nil)
    begin
      # Construir consulta base
      industries = Industry.all.order(name: :asc)

      # Aplicar filtro de búsqueda si existe
      if search_query.present?
        industries = industries.where("name LIKE ?", "%#{search_query}%")
      end

      # Calcular paginación
      total_industries = industries.count
      total_pages = (total_industries.to_f / per_page).ceil
      offset = (page - 1) * per_page

      # Obtener industries paginados
      paginated_industries = industries.offset(offset).limit(per_page)

      pagination_data = {
        industries: paginated_industries,
        pagination: {
          page: page,
          per_page: per_page,
          total_industries: total_industries,
          total_pages: total_pages,
          start_record: offset + 1,
          end_record: [offset + per_page, total_industries].min
        }
      }

      build_response(data: pagination_data, message: "Lista de industrias obtenida exitosamente")
    rescue => e
      handle_error("Error al obtener las industrias: #{e.message}", e.backtrace)
    end
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