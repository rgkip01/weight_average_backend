# frozen_string_literal: true

class CalculoMediaService
  def initialize(avaliacao: nil, projeto: nil)
    @avaliacao = avaliacao
    @projeto = projeto
  end

  def calcular_media_ponderada
    return 0 unless @avaliacao&.notas&.any?

    total_peso = @avaliacao.notas.joins(:criterio).sum('criterios.peso')
    return 0 if total_peso.zero?

    (@avaliacao.notas.joins(:criterio).sum('notas.nota * criterios.peso') / total_peso).round(2)
  end

  def calcular_media_total
    return 0 unless @projeto&.avaliacoes&.any?

    total = @projeto.avaliacoes.sum do |avaliacao|
      new_instance = self.class.new(avaliacao: avaliacao)
      new_instance.calcular_media_ponderada
    end
    (total / @projeto.avaliacoes.count).round(2)
  end
end
