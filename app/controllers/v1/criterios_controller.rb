# frozen_string_literal: true

module V1
  class CriteriosController < ApplicationController
    before_action :set_criterio, only: [:update]

    def create
      @criterio = Criterio.new(criterio_params)

      if @criterio.save
        render json: @criterio, status: :created
      else
        render json: @criterio.errors, status: :unprocessable_entity
      end
    end

    def update
      if @criterio.update(criterio_params)
        render json: @criterio, status: :ok
      else
        render json: @criterio.errors, status: :unprocessable_entity
      end
    end

    private

    def set_criterio
      @criterio = Criterio.find(params[:id])
    end

    def criterio_params
      params.require(:criterio).permit(:peso)
    end
  end
end
