# app/models/industry.rb
class Industry < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
end