# app/services/period_service.rb
class PeriodService < ApplicationService
    def self.fetch_all(page: 1, per_page: 10, search_query: nil)
    begin
      # Construir consulta base
      periods = Period.all.order(name: :asc)

      # Aplicar filtro de búsqueda si existe
      if search_query.present?
        periods = periods.where("name LIKE ?", "%#{search_query}%")
      end

      # Calcular paginación
      total_periods = periods.count
      total_pages = (total_periods.to_f / per_page).ceil
      offset = (page - 1) * per_page

      # Obtener periods paginados
      paginated_periods = periods.offset(offset).limit(per_page)

      pagination_data = {
        periods: paginated_periods,
        pagination: {
          page: page,
          per_page: per_page,
          total_periods: total_periods,
          total_pages: total_pages,
          start_record: offset + 1,
          end_record: [offset + per_page, total_periods].min
        }
      }

      build_response(data: pagination_data, message: "Lista de periodos obtenida exitosamente")
    rescue => e
      handle_error("Error al obtener las periodos: #{e.message}", e.backtrace)
    end
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