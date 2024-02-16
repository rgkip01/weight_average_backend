# frozen_string_literal: true

FactoryBot.define do
  factory :projeto do
    nome { Faker::Company.name }
    media_total { Faker::Number.between(from: 0.0, to: 10.0) }
  end
end
