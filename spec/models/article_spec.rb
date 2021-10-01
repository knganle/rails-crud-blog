require 'rails_helper'

RSpec.describe Article, type: :model do
  current_user = User.find_or_create_by!(email: 'user@example.com')
  it 'has a title' do
    article = Article.new(
      title: '',
      body: 'A valid body',
      status: 'public',
      user_id: current_user.id
    )
    expect(article).to_not be_valid
    article.title = 'A valid title'
    expect(article).to be_valid
  end

  it 'has a body' do
    article = Article.new(
      title: 'A valid title',
      body: '',
      status: 'public',
      user_id: current_user.id
    )
    expect(article).to_not be_valid
    article.body = 'A valid body'
    expect(article).to be_valid
  end

  it 'has a body at least 6 characters long' do
    article = Article.new(
      title: 'A valid title',
      body: 'Body',
      status: 'public',
      user_id: current_user.id
    )
    expect(article).to_not be_valid
    article.body = 'A valid body'
    expect(article).to be_valid
  end
end
