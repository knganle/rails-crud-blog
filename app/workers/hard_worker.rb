class HardWorker
  include Sidekiq::Worker
  # sidekiq_options retry: false
  # retry_on ErrorLoadingSite, wait: 5.minutes, queue: :low_priority

  def perform(article_id)
    puts 'Performing................................................................'
    @article = Article.find(article_id)
    @article.update(status: 'public')
  end
end
