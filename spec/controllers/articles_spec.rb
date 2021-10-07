require 'rails_helper'

describe 'Articles' do
  context 'GET /api/articles' do
    it 'return all articles' do
      get '/api/articles'
      expect(response).to have_http_status(:success)
    end
  end
  context 'GET /api/articles/:id' do
    it 'returns a status by id' do
      get "/api/statuses/#{status.id}"
      expect(response.body).to eq status.to_json
    end
  end
end
