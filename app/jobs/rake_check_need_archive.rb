class RakeCheckNeedArchive < ApplicationJob
  queue_as :high_priority

  def perform
    Article.all.each do |article|
      article.update(status: 'archived') if article.expiration < Time.now
    end
  end
end
