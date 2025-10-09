# app/models/specialism.rb
class Specialism < ApplicationRecord
  validates :name, presence: true, length: { maximum: 70 }
end