module API
  module V1
    class Comments < Grape::API
      version 'v1', using: :path, vendor: 'blog'

      namespace 'articles/:article_id' do
        resources :comments do
          desc 'Create a comment.'
          params do
            requires :commenter, type: String
            requires :body, type: String
          end
          post do
            article = Article.find(params[:article_id])
            article.comments.create!({
                                       commenter: params[:commenter],
                                       body: params[:body]
                                     })
          end

          desc 'Update a comment.'
          params do
            requires :id, type: String
            requires :commenter, type: String
            requires :body, type: String
          end
          put ':id' do
            article = Article.find(params[:article_id])
            article.comments.find(params[:id]).update!({
                                                         commenter: params[:commenter],
                                                         body: params[:body]
                                                       })
          end

          desc 'Delete a comment.'
          params do
            requires :id, type: String, desc: 'Status ID.'
          end
          delete ':id' do
            article = Article.find(params[:article_id])
            article.comments.find(params[:id]).destroy
          end
        end
      end
    end
  end
end
