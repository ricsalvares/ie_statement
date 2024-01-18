# frozen_string_literal: true

module Services
  class CalculateDisposableIncome
    def initialize(statement)
      @statement = statement
    end

    def call
      {
        disposable_income: calculate_disposable_income,
        income_sum: income_items_sum,
        expenditure_sum: expenditure_items_sum
      }
    end

    private

    attr_reader :statement

    def calculate_disposable_income
      income_items_sum - expenditure_items_sum
    end

    def income_items_sum
      statement.statement_items.income.pluck(:amount_pennies).sum
    end

    def expenditure_items_sum
      statement.statement_items.expenditure.pluck(:amount_pennies).sum
    end
  end
end
