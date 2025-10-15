# app/services/program_type_service.rb
class ProgramTypeService < ApplicationService
  def self.fetch_all(page: 1, per_page: 10, search_query: nil)
    begin
      # Construir consulta base
      program_types = ProgramType.all.order(name: :asc)

      # Aplicar filtro de búsqueda si existe
      if search_query.present?
        program_types = program_types.where("name LIKE ?", "%#{search_query}%")
      end

      # Calcular paginación
      total_program_types = program_types.count
      total_pages = (total_program_types.to_f / per_page).ceil
      offset = (page - 1) * per_page

      # Obtener program_types paginados
      paginated_program_types = program_types.offset(offset).limit(per_page)

      pagination_data = {
        program_types: paginated_program_types,
        pagination: {
          page: page,
          per_page: per_page,
          total_program_types: total_program_types,
          total_pages: total_pages,
          start_record: offset + 1,
          end_record: [offset + per_page, total_program_types].min
        }
      }

      build_response(data: pagination_data, message: "Lista de programas obtenida exitosamente")
    rescue => e
      handle_error("Error al obtener las programas: #{e.message}", e.backtrace)
    end
  end

  def self.fetch_one(id)
    program_type = ProgramType.find_by(id: id)
    return handle_not_found("Tipo de programa no encontrado") unless program_type
    
    build_response(data: program_type, message: "Tipo de Programa encontrado")
  rescue => e
    handle_error("Error al buscar el tipo de programa: #{e.message}", e.backtrace)
  end

  def self.create(params)
    program_type = ProgramType.new(params)
    if program_type.save
      build_response(data: program_type, message: "Tipo de programa creado exitosamente")
    else
      handle_validation_error(program_type)
    end
  rescue => e
    handle_error("Error al crear tipo de programa: #{e.message}", e.backtrace)
  end

  def self.update(id, params)
    program_type = ProgramType.find_by(id: id)
    return handle_not_found("Tipo de programa no encontrado") unless program_type

    if program_type.update(params)
      build_response(data: program_type, message: "Tipo de programa actualizado exitosamente")
    else
      handle_validation_error(program_type)
    end
  rescue => e
    handle_error("Error al actualizar tipo de programa: #{e.message}", e.backtrace)
  end

  def self.delete(id)
    program_type = ProgramType.find_by(id: id)
    return handle_not_found("Tipo de programa no encontrado") unless program_type

    if program_type.destroy
      build_response(message: "Tipo de programa eliminado exitosamente")
    else
      handle_error("No se pudo eliminar el tipo de programa")
    end
  rescue => e
    handle_error("Error al eliminar tipo de programa: #{e.message}", e.backtrace)
  end
end