# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::CreateStatement do
  subject { described_class.new(**params).call }
  let(:params) do
    {
      user:,
      items: [
        {
          'name': 'Found on the ground',
          'statement_type': 1,
          'amount_pennies': '12300'
        },
        {
          'name': 'pay back borrowed money',
          'statement_type': 0,
          'amount_pennies': '5000'
        }
      ]
    }
  end

  context 'call' do
    context 'when all correct params are provided' do
      let(:user) { create(:user) }
      it 'creates the statment successfully' do
        expect { subject }
          .to change(Statement, :count).by(1)
          .and change(StatementItem, :count).by(2)
      end

      it 'calls external services' do
        expect(::Services::CalculateDisposableIncome).to receive(:new).and_call_original
        expect_any_instance_of(::Services::CalculateDisposableIncome).to receive(:call).and_call_original

        expect(::Services::CalculateIeRating).to receive(:new).with(1_230_000, 5000_00).and_call_original
        expect_any_instance_of(::Services::CalculateIeRating).to receive(:call).and_call_original

        subject
      end
    end

    context 'when all correct params are provided' do
      let(:user) { build(:user) }

      it 'does not save the statement' do
        expect { subject }.not_to change(Statement, :count)
      end
    end
  end
end