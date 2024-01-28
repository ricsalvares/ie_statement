# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Statements', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/api/v1/statements/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/api/v1/statements/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/api/v1/statements/show'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /update' do
    it 'returns http success' do
      get '/api/v1/statements/update'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      get '/api/v1/statements/destroy'
      expect(response).to have_http_status(:success)
    end
  end
end
