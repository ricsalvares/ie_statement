# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::UpdateStatement do
  subject { described_class.new(**params).call }
  let(:params) do
    {
      statement:,
      user:,
      items: [{ 'name' => 'rent',
                'amount_pennies' => '234.52',
                'statement_type' => '0',
                'id' => updated_item.id,
                '_destroy' => '' },
              {
                'name' => 'salary',
                'amount_pennies' => '15234.23',
                'statement_type' => '1',
                'id' => '',
                '_destroy' => ''
              },
              {
                'name' => 'rent',
                'amount_pennies' => '1434.23',
                'statement_type' => '0',
                'id' => deleted_item.id,
                '_destroy' => '1'
              }]
    }
  end

  context 'call' do
    context 'when all correct params are provided' do
      let(:statement) { create(:statement) }
      let(:deleted_item) { create(:statement_item, statement:) }
      let(:updated_item) { create(:statement_item, statement:) }
      let(:user) { create(:user) }

      it 'updates the statement successfully' do
        expect(statement.statement_items).to include(deleted_item, updated_item)
        subject
        expect(statement.statement_items).not_to include(deleted_item)
        expect(updated_item.reload.name).to eq 'rent'
        expect(statement.ie_rating).not_to be_nil
        expect(statement.disposable_income_pennies).not_to be_nil
      end

      it 'calls external services' do
        expect(::Services::CalculateDisposableIncome).to receive(:new).and_call_original
        expect_any_instance_of(::Services::CalculateDisposableIncome).to receive(:call).and_call_original

        expect(::Services::CalculateIeRating).to receive(:new).with(1_523_423, 23_452).and_call_original
        expect_any_instance_of(::Services::CalculateIeRating).to receive(:call).and_call_original

        subject
      end
    end

    pending 'Missing specs to cover when it fails'
  end
end
