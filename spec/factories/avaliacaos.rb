# frozen_string_literal: true

FactoryBot.define do
  factory :avaliacao do
    media_ponderada { 1.5 }
    projeto { nil }
  end
end
