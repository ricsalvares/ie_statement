# frozen_string_literal: true

class StatementItem < ApplicationRecord
  belongs_to :statement

  # validations
  validates :statement, presence: true
  validates :statement_type, presence: true

  # scopes
  # scope :by_user, ->(user) { where(user:) }

  enum statement_type: {
    expenditure: 0,
    income: 1
  }
end
