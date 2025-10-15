# app/services/specialism_service.rb
class SpecialismService < ApplicationService
  def self.fetch_one(id)
    specialism = Specialism.find_by(id: id)
    return handle_not_found("Especialidad no encontrado") unless specialism
    
    build_response(data: specialism, message: "Especialidad encontrada")
  rescue => e
    handle_error("Error al buscar especialidad: #{e.message}", e.backtrace)
  end

  def self.fetch_all(page: 1, per_page: 10, search_query: nil)
    begin
      # Construir consulta base
      specialisms = Specialism.all.order(name: :asc)

      # Aplicar filtro de búsqueda si existe
      if search_query.present?
        specialisms = specialisms.where("name LIKE ?", "%#{search_query}%")
      end

      # Calcular paginación
      total_specialisms = specialisms.count
      total_pages = (total_specialisms.to_f / per_page).ceil
      offset = (page - 1) * per_page

      # Obtener specialisms paginados
      paginated_specialisms = specialisms.offset(offset).limit(per_page)

      pagination_data = {
        specialisms: paginated_specialisms,
        pagination: {
          page: page,
          per_page: per_page,
          total_specialisms: total_specialisms,
          total_pages: total_pages,
          start_record: offset + 1,
          end_record: [offset + per_page, total_specialisms].min
        }
      }

      build_response(data: pagination_data, message: "Lista de espcialidades obtenida exitosamente")
    rescue => e
      handle_error("Error al obtener las espcialidades de mentores: #{e.message}", e.backtrace)
    end
  end


  def self.create(params)
    specialism = Specialism.new(params)
    if specialism.save
      build_response(data: specialism, message: "Especialidad creada exitosamente")
    else
      handle_validation_error(specialism)
    end
  rescue => e
    handle_error("Error al crear especialidad: #{e.message}", e.backtrace)
  end

  def self.update(id, params)
    specialism = Specialism.find_by(id: id)
    return handle_not_found("Especialidad no encontrada") unless specialism

    if specialism.update(params)
      build_response(data: specialism, message: "Especialidad actualizada exitosamente")
    else
      handle_validation_error(specialism)
    end
  rescue => e
    handle_error("Error al actualizar especialidad: #{e.message}", e.backtrace)
  end

  def self.delete(id)
    specialism = Specialism.find_by(id: id)
    return handle_not_found("Especialidad no encontrada") unless specialism

    if specialism.destroy
      build_response(message: "Especialidad eliminada exitosamente")
    else
      handle_error("No se pudo eliminar el especialidad")
    end
  rescue => e
    handle_error("Error al eliminar especialidad: #{e.message}", e.backtrace)
  end
end