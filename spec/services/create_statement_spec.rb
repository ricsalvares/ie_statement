# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::CreateStatement do
  subject { described_class.new(**params).call }
  let(:params) do
    {
      user: user
    }
  end

  context 'call' do
    context 'when all correct params are provided' do
      let(:user) { create(:user) }
      it 'creates the statment successfully' do
        expect { subject }.to change(Statement, :count).by(1)
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
