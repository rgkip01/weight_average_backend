# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Projeto, type: :model do
  it 'é invalido sem um nome' do
    projeto = build(:projeto, nome: nil)

    expect(projeto).not_to be_valid
  end

  it 'tem uma relação has_many com avaliacoes' do
    expect(subject).to have_many(:avaliacoes).class_name('Avaliacao').dependent(:destroy)
  end

  describe 'callbacks' do
    let(:projeto) { create(:projeto) }

    it 'chama método atualizar_media_total após salvar' do
      allow(projeto).to receive(:atualizar_media_total)
      projeto.run_callbacks(:save)
      expect(projeto).to have_received(:atualizar_media_total)
    end
  end

  describe '#atualizar_media_total' do
    let(:projeto) { create(:projeto) }
    let(:calculo_media_service) { instance_double('CalculoMediaService') }

    before do
      allow(CalculoMediaService).to receive(:new).with(projeto: projeto).and_return(calculo_media_service)
    end

    it 'atualiza a media_total do projeto com sucesso' do
      allow(calculo_media_service).to receive(:calcular_media_total).and_return(10.0)
      projeto.send(:atualizar_media_total)
      expect(projeto.media_total).to eq(10.0)
    end

    it 'não atualiza media_total se o service de cálculo falhar' do
      allow(calculo_media_service).to receive(:calcular_media_total).and_raise(StandardError)

      expect do
          projeto.send(:atualizar_media_total)
      rescue StandardError
          StandardError
      end.not_to change(projeto, :media_total)
    end
  end
end
