# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Statement, type: :model do
  context 'associations' do
    it { is_expected.to have_many(:statement_items).dependent(:destroy) }
    it { is_expected.to belong_to(:user) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:user) }
  end

  context 'scopes' do
    context 'by_user' do
      before { create(:statement) }

      it 'queries statement by user' do
        user = create(:user)
        statement = create(:statement, user:)
        expect(Statement.by_user(user)).to match([statement])
      end
    end
  end
end
