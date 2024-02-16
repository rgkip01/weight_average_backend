# frozen_string_literal: true

FactoryBot.define do
  factory :projeto do
    nome { Faker::Company.name }
  end
end
