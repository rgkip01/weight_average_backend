# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Criterio, type: :model do
  describe 'Validações' do
    it { is_expected.to have_many(:notas).dependent(:destroy) }
    it { is_expected.to validate_presence_of(:peso) }
  end

  describe 'callbacks' do
    let(:criterio) { create(:criterio) }
    let(:nota) { create(:nota, criterio: criterio) }

    it 'chama recalcular_medias após atualização' do
      allow(criterio).to receive(:recalcular_medias)
      criterio.run_callbacks(:update)
      expect(criterio).to have_received(:recalcular_medias)
    end
  end

  describe '#recalcular_medias' do
    let!(:criterio) { create(:criterio) }
    let!(:nota) { create(:nota, criterio: criterio) }
    let!(:avaliacao) { nota.avaliacao }
    let!(:projeto) { avaliacao.projeto }
    let!(:servico_avaliacao) { instance_double('CalculoMediaService') }
    let!(:servico_projeto) { instance_double('CalculoMediaService') }

    before do
      allow(CalculoMediaService).to receive(:new).and_return(servico_avaliacao, servico_projeto)
      allow(servico_avaliacao).to receive(:calcular_media_ponderada).and_return(5.0)
      allow(servico_projeto).to receive(:calcular_media_total).and_return(7.5)
    end

    it 'atualiza media ponderada das avaliações e media total do projeto com sucesso' do
      criterio.send(:recalcular_medias)
      expect(avaliacao.reload.media_ponderada).to eq(5.0)
      expect(projeto.reload.media_total).to eq(7.5)
    end

    it 'não falha silenciosamente se ocorrer um erro no cálculo da média ponderada' do
      allow(servico_avaliacao).to receive(:calcular_media_ponderada).and_raise(StandardError)
      expect { criterio.send(:recalcular_medias) }.to raise_error(StandardError)
    end

    it 'não falha silenciosamente se ocorrer um erro no cálculo da média total' do
      allow(servico_projeto).to receive(:calcular_media_total).and_raise(StandardError)
      expect { criterio.send(:recalcular_medias) }.to raise_error(StandardError)
    end
  end
end
