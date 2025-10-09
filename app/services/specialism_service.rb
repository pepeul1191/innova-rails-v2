# app/services/specialism_service.rb
class SpecialismService < ApplicationService
  def self.fetch_all
    specialisms = Specialism.all.order(name: :asc)
    build_response(data: specialisms, message: "Lista de especialidades obtenida exitosamente")
  rescue => e
    handle_error("Error al obtener las especialidades: #{e.message}", e.backtrace)
  end

  def self.fetch_one(id)
    specialism = Specialism.find_by(id: id)
    return handle_not_found("Especialidad no encontrado") unless specialism
    
    build_response(data: specialism, message: "Especialidad encontrada")
  rescue => e
    handle_error("Error al buscar especialidad: #{e.message}", e.backtrace)
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