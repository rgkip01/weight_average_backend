# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CalculoMediaService do
  describe '#calcular_media_ponderada' do
    let(:avaliacao) { create(:avaliacao) }
    let(:criterio) { create(:criterio, peso: 2) }
    let!(:notas) do
      create(:nota, avaliacao: avaliacao, criterio: criterio, nota: 8)
      create(:nota, avaliacao: avaliacao, criterio: criterio, nota: 6)
    end

    it 'calcula a média ponderada corretamente' do
      service = CalculoMediaService.new(avaliacao: avaliacao)
      expect(service.calcular_media_ponderada).to eq(7.00)
    end

    context 'quando não há notas' do
      let(:avaliacao_sem_notas) { create(:avaliacao) }

      it 'retorna zero' do
        service = CalculoMediaService.new(avaliacao: avaliacao_sem_notas)
        expect(service.calcular_media_ponderada).to eq(0)
      end
    end
  end

  describe '#calcular_media_total' do
    let(:projeto) { create(:projeto) }
    let!(:avaliacoes) do
      create_list(:avaliacao, 5, projeto: projeto).each do |avaliacao|
        create(:nota, avaliacao: avaliacao, nota: 8)
      end
    end

    it 'calcula a média total corretamente' do
      service = CalculoMediaService.new(projeto: projeto)
      expect(service.calcular_media_total).to eq(8.00)
    end

    context 'quando não há avaliações' do
      let(:projeto_sem_avaliacoes) { create(:projeto) }

      it 'retorna zero' do
        service = CalculoMediaService.new(projeto: projeto_sem_avaliacoes)
        expect(service.calcular_media_total).to eq(0)
      end
    end
  end
end
