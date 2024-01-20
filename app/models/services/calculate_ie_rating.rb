# frozen_string_literal: true

module Services
  class CalculateIeRating
    def initialize(income_amount_pennies, expenditure_amount_pennies)
      @income_amount_pennies = income_amount_pennies
      @expenditure_amount_pennies = expenditure_amount_pennies
    end

    def call
      calculate_ie_rating
    end

    private

    attr_reader :expenditure_amount_pennies, :income_amount_pennies

    def calculate_ie_rating
      return 'D' if income_amount_pennies <= 0
      return 'A' if ie_rating < 10
      return 'B' if ie_rating < 30
      return 'C' if ie_rating < 50

      'D'
    end

    def ie_rating
      expenditure_amount_pennies.fdiv(income_amount_pennies) * 100
    end
  end
end
