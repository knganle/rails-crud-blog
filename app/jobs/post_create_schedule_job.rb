class PostCreateScheduleJob < ApplicationJob
  queue_as :default

  def perform(article)
    # Do something later
    @article = Article.find(article.id)
    @article.update(status: 'public')
  end
end
