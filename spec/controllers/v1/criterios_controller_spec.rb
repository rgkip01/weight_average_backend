# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::CriteriosController, type: :controller do
  describe 'POST #create' do
    context 'com parâmetros válidos' do
      it 'cria um novo Criterio' do
        expect {
          post :create, params: { criterio: { peso: 9.4 } }
        }.to change(Criterio, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'com parâmetros inválidos' do
      it 'não cria um novo Criterio' do
        expect {
          post :create, params: { criterio: { peso: nil } }
        }.to_not change(Criterio, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    let!(:criterio) { create(:criterio) }

    context 'com parâmetros válidos' do
      it 'atualiza o critério solicitado' do
        put :update, params: { id: criterio.id, criterio: { peso: 8.5 } }
        criterio.reload
        expect(criterio.peso).to eq(8.5)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'com parâmetros inválidos' do
      it 'não atualiza o Critério' do
        expect {
          put :update, params: { id: criterio.id, criterio: { peso: nil } }
        }.to_not change { criterio.reload.peso }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
