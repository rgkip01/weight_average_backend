# frozen_string_literal: true

module V1
  class ProjetosController < ApplicationController
    def create
     @projeto = Projeto.new(projeto_params)

     if @projeto.save
      render json: @projeto, status: :created
     else
      render json: @projeto.errors, status: :unprocessable_entity
     end
    end

    def index
      if params[:per_page].to_i > 100
        render json: { error: 'Per page limit is 100' }, status: :unprocessable_entity
      else
        per_page = params[:per_page].present? ? [params[:per_page].to_i, 100].min : 25
        @projetos = Projeto.page(params[:page]).per(per_page)
        render json: @projetos, status: :ok
      end
    end

    def projeto_params
      params.require(:projeto).permit(
        :nome,
        avaliacoes_attributes: [
          :id,
          :media_ponderada,
          :_destroy,
          { notas_attributes: [
            :id,
            :nota,
            :criterio_id,
            :_destroy
          ] }
        ]
      )
    end
  end
end
