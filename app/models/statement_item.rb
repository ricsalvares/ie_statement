# frozen_string_literal: true

class StatementItem < ApplicationRecord
  belongs_to :statement

  # validations
  validates :statement, presence: true
  validates :statement_type, presence: true
  validates :name, presence: true
  validates :amount_pennies, presence: true

  enum statement_type: {
    expenditure: 0,
    income: 1
  }
end
