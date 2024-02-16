# frozen_string_literal: true

FactoryBot.define do
  factory :criterio do
    peso { Faker::Number.between(from: 0.1, to: 10.0) }
  end
end
