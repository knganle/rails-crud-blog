require 'rails_helper'

RSpec.describe '/articles', type: :request do
  before	do
    @user	=	User.create(id: 1, email: 'user@example.com')
    @user.save
  end

  let(:valid_attributes) do
    {
      'id' => '1',
      'title' => 'Test',
      'body' => '12345',
      'status' => 'public',
      'user_id' => @user.id
    }
  end

  let(:invalid_attributes) do
    {
      'id' => 'a',
      'title' => '1',
      'body' => '1234',
      'user_id' => @user.id
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      sign_in	@user
      article = Article.new(valid_attributes)
      article.user = @user
      article.save
      get articles_url
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      sign_in	@user
      get new_article_url
      expect(response).to have_http_status(:success)
    end
  end

  # describe 'GET /edit' do
  #   it 'render a successful response' do
  #     sign_in	@user
  #     user = User.find(@user.id)
  #     article = user.articles.create(valid_attributes)
  #     article.save
  #     article = Article.find(article.id)
  #     puts '----------------------------------------------------'
  #     puts edit_article_url(article)
  #     get edit_article_url(article)
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  #   describe 'POST /create' do
  #     context 'with valid parameters' do
  #       it 'creates a new article' do
  #         sign_in	@user
  #         expect do
  #           article = Article.new(valid_attributes)
  #           article.user = @user
  #           article.save
  #           post articles_url, params: { article: valid_attributes }
  #         end
  #       end

  #       it 'redirects to the created article' do
  #         sign_in	@user
  #         post articles_url, params: { post: valid_attributes }
  #         eexpect(response).to have_http_status(:success)
  #       end
  #     end

  #     context 'with invalid parameters' do
  #       it 'does not create a new Article' do
  #         sign_in	@user
  #         expect do
  #           post articles_url, params: { post: invalid_attributes }
  #         end
  #       end

  #       it "renders a successful response (i.e. to display the 'new' template)" do
  #         sign_in	@user
  #         post articles_url, params: { post: invalid_attributes }
  #         expect(response).to have_http_status(:success)
  #       end
  #     end
  #   end

  #   describe 'PATCH /update' do
  #     context 'with valid parameters' do
  #       let(:new_attributes) do
  #         {
  #           'id' => '1',
  #           'title' => 'Test',
  #           'body' => '12345',
  #           'user_id' => @user.id
  #         }
  #       end

  #       it 'updates the requested article' do
  #         sign_in	@user
  #         article = Article.new(valid_attributes)
  #         article.user = @user
  #         article.save
  #         patch post_url(post), params: { post: new_attributes }
  #         article.reload
  #         skip('Add assertions for updated state')
  #       end

  #       it 'redirects to the article' do
  #         sign_in	@user
  #         article = Article.new(valid_attributes)
  #         article.user = @user
  #         article.save
  #         patch article(article), params: { article: new_attributes }
  #         article.reload
  #         expect(response).to redirect_to(article_url(article))
  #       end
  #     end
  #   end

  describe 'DELETE /destroy' do
    it 'destroys the requested article' do
      article = Article.new(valid_attributes)
      article.user = @user
      article.save
      expect do
        delete article_url(post)
      end
    end
  end
end
