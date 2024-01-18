# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable  Metrics/BlockLength
RSpec.describe Services::CalculateIeRating do
  subject { described_class.new(income_amount_pennies, expenditure_amount_pennies).call }

  context 'call' do
    # TODO: use shared example + random values
    context 'when calculated rating is A' do
      let(:expenditure_amount_pennies) { 20_000 }
      let(:income_amount_pennies) { 500_000 }

      it { is_expected.to eq 'A' }
    end

    context 'when calculated rating is B' do
      let(:expenditure_amount_pennies) { 200_000 }
      let(:income_amount_pennies) { 700_000 }

      it { is_expected.to eq 'B' }
    end

    context 'when calculated rating is C' do
      let(:expenditure_amount_pennies) { 200_000 }
      let(:income_amount_pennies) { 500_000 }

      it { is_expected.to eq 'C' }
    end

    context 'when calculated rating is D' do
      let(:expenditure_amount_pennies) { 400_000 }
      let(:income_amount_pennies) { 700_000 }

      it { is_expected.to eq 'D' }
    end

    context 'when income is zero' do
      let(:expenditure_amount_pennies) { 400_000 }
      let(:income_amount_pennies) { 0 }

      it { is_expected.to eq 'D' }
    end
  end
end
# rubocop:enable  Metrics/BlockLength
