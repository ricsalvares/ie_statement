# frozen_string_literal: true

FactoryBot.define do
  factory :statement, class: Statement do
    association :user
  end

  trait :with_statement_item do
    after(:build) do |statement, _evaluator|
      item = build(:statement_item, statement:)
      statement.statement_items << item
    end
  end
end
