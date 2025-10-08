# app/services/period_service.rb
class PeriodService < ApplicationService
  def self.fetch_all
    periods = Period.all.order(name: :asc)
    build_response(data: periods, message: "Lista de periodos obtenida exitosamente")
  rescue => e
    handle_error("Error al obtener periodos: #{e.message}", e.backtrace)
  end

  def self.fetch_one(id)
    period = Period.find_by(id: id)
    return handle_not_found("Periodo no encontrado") unless period
    
    build_response(data: period, message: "Periodo encontrado")
  rescue => e
    handle_error("Error al buscar periodo: #{e.message}", e.backtrace)
  end

  def self.create(params)
    period = Period.new(params)
    if period.save
      build_response(data: period, message: "Periodo creado exitosamente")
    else
      handle_validation_error(period)
    end
  rescue => e
    handle_error("Error al crear periodo: #{e.message}", e.backtrace)
  end

  def self.update(id, params)
    period = Period.find_by(id: id)
    return handle_not_found("Periodo no encontrado") unless period

    if period.update(params)
      build_response(data: period, message: "Periodo actualizado exitosamente")
    else
      handle_validation_error(period)
    end
  rescue => e
    handle_error("Error al actualizar periodo: #{e.message}", e.backtrace)
  end

  def self.delete(id)
    period = Period.find_by(id: id)
    return handle_not_found("Periodo no encontrado") unless period

    if period.destroy
      build_response(message: "Periodo eliminado exitosamente")
    else
      handle_error("No se pudo eliminar el periodo")
    end
  rescue => e
    handle_error("Error al eliminar periodo: #{e.message}", e.backtrace)
  end

  def self.current_period
    period = Period.where("init_date <= ? AND end_date >= ?", Date.today, Date.today).first
    return handle_not_found("No hay un periodo activo actualmente") unless period
    
    build_response(data: period, message: "Periodo actual encontrado")
  rescue => e
    handle_error("Error al obtener periodo actual: #{e.message}", e.backtrace)
  end
end