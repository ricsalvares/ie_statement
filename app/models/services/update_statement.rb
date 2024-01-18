# frozen_string_literal: true

module Services
  class UpdateStatement
    def initialize(statement:, user:, items: [])
      @user = user
      @items = items
      @statement = statement
    end

    def call
      delete_items
      update_items
      create_items

      update_statement_ratings
      statement.reload
    end

    private

    attr_reader :user, :items, :statement

    def update_statement_ratings
      disposable_income = calculate_disposable_income[:disposable_income]
      ie_rating = calculate_ie_rating(calculate_disposable_income)
      statement.update(disposable_income_pennies: disposable_income, ie_rating:)
    end

    def calculate_disposable_income
      @calculate_disposable_income ||= CalculateDisposableIncome.new(statement).call
    end

    def calculate_ie_rating(params)
      CalculateIeRating.new(params[:income_sum], params[:expenditure_sum]).call
    end

    def delete_items
      items_to_be_deleted.delete_all
    end

    def items_to_be_deleted
      ids = items.map { |item| item['id'] if item['_destroy'] == '1' && item['id'] }.compact
      StatementItem.where(statement_id: statement.id, id: ids)
    end

    def update_items
      statement_items = StatementItem.where(statement_id: statement.id, id: items_to_be_updated.keys).index_by(&:id)
      statement_items.each do |id, statement_item|
        params = param_by_item(items_to_be_updated[id].with_indifferent_access)
        statement_item.update(**params)
      end
    end

    def items_to_be_updated
      @items_to_be_updated ||= {}.tap do |to_be_updated|
        items.each do |item|
          if item['_destroy'] != '1' && item['id'].present?
            to_be_updated[item['id'].to_i] =
              item.except('_destroy', 'id')
          end
        end
      end
    end

    def create_items
      items_to_be_created.each do |item|
        statement.statement_items.create(**param_by_item(item.with_indifferent_access))
      end
    end

    def items_to_be_created
      items.select { |item| item['_destroy'] != '1' && !item['id'].present? }
    end

    def param_by_item(item)
      {
        name: item[:name],
        statement_type: item[:statement_type].to_i,
        amount_pennies: item.fetch(:amount_pennies, 0).to_f * 100 # converts into pennies
      }
    end
  end
end
