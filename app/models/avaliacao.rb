class Avaliacao < ApplicationRecord
  belongs_to :projeto
  has_many :notas, dependent: :destroy
  accepts_nested_attributes_for :notas

  after_save :atualizar_media_ponderada

  private

  def atualizar_media_ponderada
    servico = CalculoMediaService.new(avaliacao: self)
    self.update_column(:media_ponderada, servico.calcular_media_ponderada)
  end
end
