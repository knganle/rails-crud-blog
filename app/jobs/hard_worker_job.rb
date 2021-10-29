class HardWorker
  include Sidekiq::Worker
  # sidekiq_options retry: false

  def perform(article_id)
    @article = Article.find(article_id)
    @article.update(status: 'public')
  end
end
