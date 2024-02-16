# frozen_string_literal: true

class Projeto < ApplicationRecord
  has_many :avaliacoes, class_name: 'Avaliacao', dependent: :destroy
  accepts_nested_attributes_for :avaliacoes

  after_save :atualizar_media_total

  private

  def atualizar_media_total
    servico = CalculoMediaService.new(projeto: self)
    self.update_column(:media_total, servico.calcular_media_total)
  end
end
