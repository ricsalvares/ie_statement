# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable  Metrics/BlockLength
RSpec.describe 'Statements', type: :request do
  describe 'GET /index' do
    context 'when successfully signed in' do
      let(:user) { create(:user) }
      before { sign_in user }

      it 'renders statement index' do
        get statements_path

        expect(response.status).to eq(200)
        expect(response.body).to include(user.email)
      end
    end

    context 'when not logged in' do
      it 'does not render properly' do
        get statements_path

        expect(response.status).to eq(302)
      end
    end
  end

  describe 'GET /SHOW' do
    context 'when successfully signed in' do
      let(:user) { create(:user) }
      before { sign_in user }

      it 'renders statement show page' do
        statement = create(:statement, user:)
        get statement_path(statement)

        expect(response.status).to eq(200)
        expect(response.body).to include(user.email.to_s)
        expect(response.body).to include("Statment ##{statement.id}")
      end
    end

    context 'when not logged in' do
      it 'does not render show page properly' do
        statement = create(:statement)
        get statement_path(statement)

        expect(response.status).to eq(302)
      end
    end
  end

  describe 'POST statement' do
    context 'when successfully signed in' do
      let(:user) { create(:user) }
      before { sign_in user }

      it 'creates a statement' do
        params = {
          statement: {
            statement_items_attributes: {
              '0' => { name: 'salary', amount_pennies: 40_102, statement_type: 1 }
            }
          }
        }

        expect_any_instance_of(::Services::CreateStatement).to receive(:call).and_call_original
        expect do
          post(statements_path, params:)
        end
        .to change(Statement, :count).by(1)
        expect(response.status).to eq(302)
      end
    end

    context 'when not logged in' do
      it 'does not do anything' do
        expect do
          post(statements_path, params: {})
        end.not_to change(Statement, :count)

        expect(response.status).to eq(302)
      end
    end
  end

  describe 'PUT statement' do
    context 'when successfully signed in' do
      let(:statement) { create(:statement, :with_statement_item, user:) }
      let(:user) { create(:user) }

      before { sign_in user }

      it 'updates a statement' do
        item = statement.statement_items.last
        params = {
          statement: {
            statement_items_attributes: {
              '0' => { 'name' => 'updated item',
                       'amount_pennies' => '234.52',
                       'statement_type' => '0',
                       'id' => item.id,
                       '_destroy' => '' }
            }
          }
        }

        expect_any_instance_of(::Services::UpdateStatement).to receive(:call).and_call_original
        put(statement_path(statement.id), params:)
        expect(response.status).to eq(302)

        expect(item.reload.name).to eq('updated item')
      end

      context 'when the params are not valid' do
        it do
          item = statement.statement_items.last
          params = {
            statement: {
              statement_items_attributes: {
                '0' => {
                  'amount_pennies' => '234.52',
                  'statement_type' => '0',
                  'id' => item.id,
                  '_destroy' => ''
                }
              }
            }
          }

          expect_any_instance_of(::Services::UpdateStatement).to receive(:call).and_call_original
          put(statement_path(statement.id), params:)
          expect(response.status).to eq(422)

          expect(item.reload.name).not_to eq('updated item')
        end
      end
    end

    context 'when not logged in' do
      it 'does not do anything' do
        put statement_path(1), params: {}
        expect(response.status).to eq(302)
      end
    end
  end

  describe 'DELETE statement' do
    context 'when successfully signed in' do
      let(:user) { create(:user) }
      before { sign_in user }

      it 'deletes the statement' do
        statement = create(:statement, user:)
        expect do
          delete(statement_path(statement), params: { id: statement.id })
        end
        .to change(Statement, :count).by(-1)
        expect(response.status).to eq(302)
      end
    end

    context 'when not logged in' do
      it 'does not do anything' do
        statement = create(:statement)
        expect do
          delete(statement_path(statement), params: { id: statement.id })
        end.not_to change(Statement, :count)

        expect(response.status).to eq(302)
      end
    end
  end
end
# rubocop:enable  Metrics/BlockLength
