# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::CalculateIeRating do
  subject { described_class.new(income_amount_pennies, expenditure_amount_pennies).call }

  shared_examples 'I&E rating calculator' do |income, expenditure, rating|
    context "when income is #{income} and expenditure is #{expenditure}" do
      let(:income_amount_pennies) { income }
      let(:expenditure_amount_pennies) { expenditure }
      it "returns the rating: #{rating}" do
        is_expected.to eq rating
      end
    end
  end

  context 'call' do
    it_behaves_like 'I&E rating calculator', 200_100, 20_000, 'A'
    it_behaves_like 'I&E rating calculator', 700_000, 200_000, 'B'
    it_behaves_like 'I&E rating calculator', 500_000, 200_000, 'C'
    it_behaves_like 'I&E rating calculator', 400_000, 700_000, 'D'
    it_behaves_like 'I&E rating calculator', 0, 400_000, 'D'
    it_behaves_like 'I&E rating calculator', -1, 400_000, 'D'
  end
end
