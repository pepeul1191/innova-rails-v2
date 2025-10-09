# app/models/document_type.rb
class DocumentType < ApplicationRecord
  validates :name, presence: true, length: { maximum: 22 }
end