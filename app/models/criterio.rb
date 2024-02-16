# frozen_string_literal: true

class Criterio < ApplicationRecord
  has_many :notas, dependent: :destroy

  after_update :recalcular_medias

  private

  def recalcular_medias
    notas.includes(:avaliacao).each do |nota|
      avaliacao = nota.avaliacao
      projeto = avaliacao.projeto

      servico_avaliacao = CalculoMediaService.new(avaliacao: avaliacao)
      avaliacao.update_column(:media_ponderada, servico_avaliacao.calcular_media_ponderada)

      servico_projeto = CalculoMediaService.new(projeto: projeto)
      projeto.update_column(:media_total, servico_projeto.calcular_media_total)
    end
  end
end
