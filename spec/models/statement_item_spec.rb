# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StatementItem, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:statement) }
    it { is_expected.to validate_presence_of(:statement_type) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:amount_pennies) }
  end
end
