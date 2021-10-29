class AddExpirationDayToArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :expiration, :date
  end
end
