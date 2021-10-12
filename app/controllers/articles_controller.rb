class ArticlesController < ApplicationController
  # http_basic_authenticate_with name: 'nganle', password: 'nganle', except: %i[index show]
  before_action :authenticate_user!

  def index
    @articles = Article.where("status != 'private'")
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @user = User.find(current_user.id)
    @article = @user.articles.create(article_params)

    if @article
      if article_params[:status] == 'private'
        # PostCreateScheduleJob.set(wait: 1.minute).perform_later(@article)
        HardWorker.perform_at(1.minutes.from_now, @article.id)
      end
      notice_message = if article_params[:status] != 'private'
                         'Article was successfully created.'
                       else
                         'Article will be created with status private and will be public after 1 minute(s)'
                       end
      redirect_to @article, notice: notice_message
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    authorize @article
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    authorize @article
    # ArticlePolicy.new(current_user, @article).destroy?
    @article.destroy

    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :expiration, :status)
  end
end
