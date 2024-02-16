class Avaliacao < ApplicationRecord
  belongs_to :projeto
  has_many :notas, dependent: :destroy
  accepts_nested_attributes_for :notas
end
