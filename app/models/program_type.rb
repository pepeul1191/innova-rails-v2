# app/models/program_type.rb
class ProgramType < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
end