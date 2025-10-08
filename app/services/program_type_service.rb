# app/services/program_type_service.rb
class ProgramTypeService < ApplicationService
  def self.fetch_all
    program_types = ProgramType.all.order(name: :asc)
    build_response(data: program_types, message: "Lista de tipos de tipos de programa obtenida exitosamente")
  rescue => e
    handle_error("Error al obtener los tipos de programas: #{e.message}", e.backtrace)
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