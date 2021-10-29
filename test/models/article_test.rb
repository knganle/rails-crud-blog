require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'should not create article without title' do
    article = Article.new
    assert_not article.save, 'Saved the article without a title'
  end

  test 'should not create article without body' do
    article = Article.new
    assert_not article.save, 'Saved the article without a body'
  end

  test 'should not create article with body has length less than 6 characters' do
    article = Article.new
    article.body = 'Hello'
    assert_not article.save, 'Saved the article with body has length less than 6 characters'
  end

  test 'should create article valid' do
    article = Article.new
    article.title = 'Test title'
    article.body = 'Valid body'
    assert true, article.save
  end

  test 'should report error' do
    assert_raises(NameError) do
      some_undefined_variable
    end
  end
end
