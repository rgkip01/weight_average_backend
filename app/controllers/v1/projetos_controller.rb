# frozen_string_literal: true

module V1
  class ProjetosController < ApplicationController
    def create
     @projetos = Projeto.new(projeto_params)

     if @projeto.save!
      render json: @projeto, status: :created
     else
      render json: @projeto.errors, status: :unprocessable_entity
     end
    end

    def index
      @projetos = Projeto.all

      render json: @projetos, status: :ok
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
