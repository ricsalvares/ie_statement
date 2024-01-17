# frozen_string_literal: true

FactoryBot.define do
  factory :statement, class: Statement do
    association :user
  end
end
