# frozen_string_literal: true

FactoryBot.define do
  factory :nota do
    nota { Faker::Number.between(from: 0.0, to: 10.0) }
    avaliacao
    criterio
  end
end
