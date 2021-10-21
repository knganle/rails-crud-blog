class ArticlesController < ApplicationController
  # http_basic_authenticate_with name: 'nganle', password: 'nganle', except: %i[index show]
  before_action :authenticate_user!

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    authorize @article
  end

  def new
    @article = Article.new
  end

  def create
    @user = User.find(current_user.id)

    @article = Article.new(article_params)
    @article.user = current_user
    authorize @article

    @article = @user.articles.create(article_params)

    if @article
      redirect_to @article, notice: 'Article was successfully created.'
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
    params.require(:article).permit(:title, :body, :status)
  end
end
