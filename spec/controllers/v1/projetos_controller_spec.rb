# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::ProjetosController, type: :controller do
  describe 'POST #create' do
    context 'com parâmetros válidos' do
      it 'cria um novo Projeto' do
        expect do
          post :create, params: { projeto: attributes_for(:projeto) }
        end.to change(Projeto, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context 'com parâmetros inválidos' do
      it 'não cria um novo projeto' do
        expect do
          post :create, params: { projeto: attributes_for(:projeto, nome: nil) }
        end.not_to change(Projeto, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #index' do
    before do
      create_list(:projeto, 30)
    end

    it 'retorna uma lista paginada de projetos' do
      get :index, params: { page: 1, per_page: 25 }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(25)
    end

    it 'respeita o parâmetro per_page' do
      get :index, params: { page: 1, per_page: 10 }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(10)
    end

    it 'retorna um erro se o parâmetro per_page é muito alto' do
      get :index, params: { page: 1, per_page: 101 }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
