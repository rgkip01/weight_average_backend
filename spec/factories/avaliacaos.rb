# frozen_string_literal: true

FactoryBot.define do
  factory :avaliacao do
    media_ponderada { Faker::Number.between(from: 0.0, to: 10.0) }
    projeto
  end
end
