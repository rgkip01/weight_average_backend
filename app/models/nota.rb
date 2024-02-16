# frozen_string_literal: true

class Nota < ApplicationRecord
  belongs_to :avaliacao
  belongs_to :criterio

  validates :nota, presence: true
end
