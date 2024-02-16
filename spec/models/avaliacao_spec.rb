# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Avaliacao, type: :model do
  describe 'Validações' do
    it { is_expected.to belong_to(:projeto) }
    it { is_expected.to have_many(:notas).dependent(:destroy) }
    it { is_expected.to validate_presence_of(:media_ponderada) }
  end

  describe 'callbacks' do
    let(:avaliacao) { create(:avaliacao) }

    it 'atualizar_media_ponderada após salvar' do
      allow(avaliacao).to receive(:atualizar_media_ponderada)
      avaliacao.run_callbacks(:save)
      expect(avaliacao).to have_received(:atualizar_media_ponderada)
    end
  end

  describe '#atualizar_media_ponderada' do
    let(:avaliacao) { create(:avaliacao) }
    let(:servico) { instance_double(CalculoMediaService) }

    before do
      allow(CalculoMediaService).to receive(:new).with(avaliacao: avaliacao).and_return(servico)
    end

    it 'atualiza a media_ponderada com sucesso' do
      allow(servico).to receive(:calcular_media_ponderada).and_return(7.5)
      avaliacao.send(:atualizar_media_ponderada)
      expect(avaliacao.media_ponderada).to eq(7.5)
    end

    it 'não atualiza media_ponderada se o cálculo falhar' do
      allow(servico).to receive(:calcular_media_ponderada).and_raise(StandardError)

      expect do
        avaliacao.send(:atualizar_media_ponderada)
      rescue StandardError
        StandardError
      end.not_to change(avaliacao, :media_ponderada)
    end
  end
end
