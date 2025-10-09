# app/services/document_type_service.rb
class DocumentTypeService < ApplicationService
  def self.fetch_all
    document_types = DocumentType.all.order(id: :asc)
    build_response(data: document_types, message: "Lista de tipos de documentos de identidad obtenida exitosamente")
  rescue => e
    handle_error("Error al obtener los tipos de documentos de identidad: #{e.message}", e.backtrace)
  end

  def self.fetch_one(id)
    program_type = DocumentType.find_by(id: id)
    return handle_not_found("Tipo de documento de identidad no encontrado") unless program_type
    
    build_response(data: program_type, message: "Tipo de documento de entidad encontrado")
  rescue => e
    handle_error("Error al buscar el tipo de documento de identidad: #{e.message}", e.backtrace)
  end
end