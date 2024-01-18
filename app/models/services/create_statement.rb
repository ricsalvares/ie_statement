# frozen_string_literal: true

module Services
  class CreateStatementError < StandardError; end
  class CreateStatement
    def initialize(user:, items: [])
      @user = user
      @items = items
    end

    def call
      Statement.transaction do
        before_save
        statement.save!
        after_save
        statement.reload
      end
    rescue ActiveRecord::RecordInvalid => e
      # TODO handle errors properly
    ensure
      statement
    end

    private

    def before_save
      assign_statement
      build_items
    end

    def after_save
      update_disposable_income_and_ie_rating
    end

    def update_disposable_income_and_ie_rating
      disposable_income = calculate_disposable_income[:disposable_income]
      ie_rating = calculate_ie_rating(calculate_disposable_income)
      statement.update(disposable_income_pennies: disposable_income, ie_rating: ie_rating)
    end

    def calculate_disposable_income
      @calculate_disposable_income ||= CalculateDisposableIncome.new(statement).call
    end
    
    def calculate_ie_rating(params)
      CalculateIeRating.new(params[:income_sum], params[:expenditure_sum]).call
    end

    attr_reader :user, :items, :statement

    def assign_statement
      @statement = Statement.new(**statement_params)
    end

    def statement_params
      { user_id: user.id }
    end

    def build_items
      items.each do |item|
        statement.statement_items.build(**param_by_item(item))
      end
    end

    def param_by_item(item)
      {
        name: item[:name],
        statement_type: item[:statement_type].to_i,
        amount_pennies: item.fetch(:amount, 0) * 100 #converts into pennies
      }
    end
  end
end
