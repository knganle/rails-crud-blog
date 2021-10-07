require 'rails_helper'

RSpec.describe 'articles/index', type: :view do
  current_user = User.find_or_create_by!(email: 'user@example.com')

  before(:each) do
    assign(:articles, [Article.create(
      title: 'Title',
      body: 'A valid body',
      status: 'public',
      user_id: current_user.id
    )])
  end

  it 'render articles' do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/A valid body/)
  end
end
