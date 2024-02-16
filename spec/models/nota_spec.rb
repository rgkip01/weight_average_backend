# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Nota, type: :model do
  it { is_expected.to belong_to(:avaliacao) }
  it { is_expected.to belong_to(:criterio) }

  describe 'validações' do
    it 'é válida com uma nota, avaliacao e criterio' do
      nota = build(:nota)
      expect(nota).to be_valid
    end

    it 'é inválida sem uma avaliacao' do
      nota = build(:nota, avaliacao: nil)
      expect(nota).not_to be_valid
    end

    it 'é inválida sem um criterio' do
      nota = build(:nota, criterio: nil)
      expect(nota).not_to be_valid
    end
  end
end
