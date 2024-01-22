# frozen_string_literal: true

require 'rails_helper'
# rubocop:disable  Metrics/BlockLength
RSpec.describe Services::UpdateStatement do
  subject { described_class.new(**params).call }
  let(:params) do
    {
      statement:,
      user:,
      items:
    }
  end
  let(:items) { [] }

  context 'call' do
    let(:statement) { create(:statement) }
    let(:existing_item) { create(:statement_item, statement:, amount_pennies: 1_523_423) }
    let(:user) { create(:user) }

    context 'when all correct params are provided' do
      before { updated_item }
      let(:updated_item) { create(:statement_item, statement:) }
      let(:items) { super() << updated_item_params }
      let(:new_amount) { '234.52' }
      let(:new_amount_pennies) { (new_amount.to_f * 100).to_i }
      let(:updated_item_params) do
        { 'name' => 'rent',
          'amount_pennies' => new_amount,
          'statement_type' => '0',
          'id' => updated_item.id,
          '_destroy' => '' }
      end
      it 'updates the statement and its items successfully' do
        new_amount_pennies = (new_amount.to_f * 100).to_i
        expect { subject }.to change { updated_item.reload.name }
          .to('rent')
          .and(change { updated_item.amount_pennies }.to(new_amount_pennies))
          .and(change { statement.reload.ie_rating })
          .and(change { statement.disposable_income_pennies })
      end

      it 'calls external services' do
        expect(Services::CalculateDisposableIncome).to receive(:new).and_call_original
        expect_any_instance_of(Services::CalculateDisposableIncome).to receive(:call).and_call_original

        expect(Services::CalculateIeRating).to receive(:new).with(existing_item.amount_pennies,
                                                                  new_amount_pennies).and_call_original
        expect_any_instance_of(Services::CalculateIeRating).to receive(:call).and_call_original

        subject
      end
    end

    context 'when creating new statement item' do
      let(:items) { super() << item_to_create_params }
      let(:amount) { '1434.23' }
      let(:amount_pennies) { (amount.to_f * 100).to_i }
      let(:name) { 'rent' }
      let(:item_to_create_params) do
        {
          'name' => name,
          'amount_pennies' => amount,
          'statement_type' => '0',
          'id' => '',
          '_destroy' => ''
        }
      end

      let(:new_statement_item) { statement.reload.statement_items.last }

      it 'successfully creates a new statement item' do
        expect { subject }.to change(StatementItem, :count)
          .by(1)
          .and(change { statement.reload.ie_rating })
          .and(change { statement.disposable_income_pennies })

        expect(new_statement_item.name).to eq(name)
        expect(new_statement_item.statement_type).to eq('expenditure')
        expect(new_statement_item.amount_pennies).to eq(amount_pennies)
      end

      it 'calls external services' do
        expect(Services::CalculateDisposableIncome).to receive(:new).and_call_original
        expect_any_instance_of(Services::CalculateDisposableIncome).to receive(:call).and_call_original

        expect(Services::CalculateIeRating).to receive(:new).with(existing_item.amount_pennies,
                                                                  amount_pennies).and_call_original
        expect_any_instance_of(Services::CalculateIeRating).to receive(:call).and_call_original

        subject
      end
    end

    context 'when deleting statement item' do
      before { deleted_item }
      let(:deleted_item) { create(:statement_item, statement:) }
      let(:items) { super() << deleted_item_params }
      let(:deleted_item_params) do
        {
          'name' => 'rent',
          'amount_pennies' => '1434.23',
          'statement_type' => '0',
          'id' => deleted_item.id,
          '_destroy' => '1'
        }
      end

      it 'successfully deletes the statement item' do
        expect { subject }.to change(StatementItem, :count)
          .by(-1)
          .and(change { statement.reload.ie_rating })
          .and(change { statement.disposable_income_pennies })

        expect(statement.statement_items).not_to include(deleted_item)
        expect { deleted_item.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'calls external services' do
        expect(Services::CalculateDisposableIncome).to receive(:new).and_call_original
        expect_any_instance_of(Services::CalculateDisposableIncome).to receive(:call).and_call_original

        expect(Services::CalculateIeRating).to receive(:new).with(existing_item.amount_pennies, 0).and_call_original
        expect_any_instance_of(Services::CalculateIeRating).to receive(:call).and_call_original

        subject
      end
    end

    context 'when invalid params are provided' do
      let(:statement) { create(:statement) }
      let(:item) { create(:statement_item, statement:) }
      let(:user) { create(:user) }

      let(:params) do
        {
          statement:,
          user:,
          items: [{ 'name' => nil,
                    'amount_pennies' => '234.52',
                    'statement_type' => '0',
                    'id' => item.id,
                    '_destroy' => '' }]
        }
      end

      it 'adds error to the statement' do
        subject
        expect(subject.errors).not_to be_empty
      end
    end
  end
end
# rubocop:enable  Metrics/BlockLength
