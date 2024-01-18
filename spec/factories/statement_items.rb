# frozen_string_literal: true

FactoryBot.define do
  factory :statement_item do
    association :statement
    name { 'MyString' }
    statement_type { 1 }
    amount_pennies { 100 }
  end
end
