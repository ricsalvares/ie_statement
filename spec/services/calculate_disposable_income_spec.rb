# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable  Metrics/BlockLength
RSpec.describe Services::CalculateDisposableIncome do
  subject { described_class.new(statement).call }
  context 'call' do
    let(:income_statement_items) do
      [
        {
          name: 'Salary',
          statement_type: :income,
          amount_pennies: 1_412_300
        },
        {
          name: 'dividends',
          statement_type: :income,
          amount_pennies: 5300
        }
      ]
    end

    let(:expenditure_statement_items) do
      [
        {
          name: 'Rent',
          statement_type: :expenditure,
          amount_pennies: 220_000
        },
        {
          name: 'groceries',
          statement_type: :expenditure,
          amount_pennies: 12_372
        }
      ]
    end

    let(:statement) do
      create(:statement).tap do |st|
        st.statement_items << income_statement_items.map do |isi|
          create(:statement_item, statement: st, **isi)
        end

        st.statement_items << expenditure_statement_items.map do |esi|
          create(:statement_item, statement: st, **esi)
        end
      end
    end

    it do
      income_items_sum = 1_412_300 + 5300
      expenditure_items_sum = 220_000 + 12_372
      calculate_disposable_income = income_items_sum - expenditure_items_sum

      is_expected.to eq({
                          disposable_income: calculate_disposable_income,
                          income_sum: income_items_sum,
                          expenditure_sum: expenditure_items_sum
                        })
    end
  end
  # rubocop:enable  Metrics/BlockLength
end
