class Articles < Grape::API
  resource :articles do
    desc 'Return list of articles'
    get do
      Article.all
    end

    desc 'Return an article'
    params do
      requires :id, desc: 'The id of the article', type: Integer
    end
    route_param :id do
      get do
        Article.find(params[:id])
      end
    end

    desc 'Create an article'
    params do
      requires :author_id, desc: 'the author ID', type: Integer
      requires :title, desc: 'the article title'
      requires :body, desc: 'the article body'
    end

    # params do
    #   requires :id, type: Integer
    #   optional :text, type: String, regexp: /\A[a-z]+\z/
    #   group :media, type: Hash do
    #     requires :url
    #   end
    #   optional :audio, type: Hash do
    #     requires :format, type: Symbol, values: [:mp3, :wav, :aac, :ogg], default: :mp3
    #   end
    #   requires :status_code, types: [Integer, String, Array[Integer, String]]
    #   with(type: String, regexp: /w+/) do
    #     requires :first_name, desc: 'First name'
    #     requires :middle_name, desc: 'Middle name'
    #     requires :last_name, desc: 'Last name'
    #   end
    #   requires :state, type: Symbol, values: [:active, :inactive]
    #   requires :port, except_values: { value: 0..1024, message: 'is not allowed' }
    #   params do
    #     optional :beer
    #     optional :wine
    #     mutually_exclusive :beer, :wine
    #   end
    # end

    post do
      article = Article.create!({
                                  user_id: params[:author_id],
                                  title: params[:title],
                                  body: params[:body],
                                  status: params[:status] || 'public'
                                })
      article
    end

    desc 'Update an article'
    params do
      requires :id, type: Integer, desc: 'Article ID'
      requires :body, type: String, desc: 'New body'
    end
    put ':id' do
      article = Article.find(params[:id]).update({
                                                   body: params[:body]
                                                 })
      article
    end

    desc 'Delete an article'
    params do
      requires :id, type: Integer, desc: 'Article ID'
    end
    delete ':id' do
      Article.find(params[:id]).destroy
    end
  end
end

# Other Things

# -- Helpers

# module StatusHelpers
#   def user_info(user)
#     "#{user} has statused #{user.statuses} status(s)"
#   end
# end

# module HttpCodesHelpers
#   def unauthorized
#     401
#   end
# end

# helpers do
#   def current_user
#     User.find(params[:user_id])
#   end
# end

# helpers StatusHelpers, HttpCodesHelpers

# before do
#   error!('Access Denied', unauthorized) unless current_user
# end

# get 'info' do
#   # helpers available in your endpoint and filters
#   user_info(current_user)
# end

# --Routes

# route :get, 'status' do
# end

# get 'status' do
# end

# get :status do
# end

# # is NOT the same as

# get ':status' do #[:status]
# end

# get 'statuses/:status_id/reviews/:id' do # params[:status_id] and params[:id]
# end

# --- Cookies
# cookies[:status_count] += 1
# { status_count: cookies[:status_count] }

# { status_count: cookies.delete(:status_count) }

# --- Raise Exception
# error! 'Access Denied', 401
# error!('Something went wrong', 500, 'X-Error-Detail' => 'Invalid token.')

# class Article < Grape::API
#   format :json
#   rescue_from :all do |e|
#     error!({ error: 'Server error.' }, 500, { 'Content-Type' => 'text/error' })
#   end
# end

# class Article::API < Grape::API
#   rescue_from ArgumentError do |e|
#     error!("ArgumentError: #{e.message}")
#   end

#   rescue_from NoMethodError do |e|
#     error!("NoMethodError: #{e.message}")
#   end
# end
