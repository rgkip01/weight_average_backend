# frozen_string_literal: true

FactoryBot.define do
  factory :nota do
    nota { 1.5 }
    avaliacao { nil }
    criterio { nil }
  end
end