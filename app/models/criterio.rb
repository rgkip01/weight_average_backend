class Criterio < ApplicationRecord
  has_many :notas, dependent: :destroy

  after_update :reculcular_medias

  private

  def reculcular_medias
    notas.each do |nota|
      CalculoMedidaService.atualizar_medias(nota.avaliacao)
    end
  end
end
