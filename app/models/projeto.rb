class Projeto < ApplicationRecord
  has_many :avaliacoes, dependent: :destroy
  accepts_nested_attributes_for :avaliacoes
end
