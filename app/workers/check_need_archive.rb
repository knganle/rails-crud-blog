class CheckNeedArchive
  def self.perform
    Article.all.each do |article|
      article.update(status: 'archived') if article.expiration < Time.now
    end
  end
end
