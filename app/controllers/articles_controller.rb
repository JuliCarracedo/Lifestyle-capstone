class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :authenticate_user, except: :index

  # GET /articles or /articles.json
  def index
    @categories = Category.order(:priority)
    @categories_limited = @categories.slice(0, 4)
    most_voted_id = Vote.most_voted_id
    @featured_article = if most_voted_id.nil?

                          Article.first || Article.new(title: 'Create your own article',
                                                       text: 'People at Lifestyle want to know you better!
                          Tell us your story and receive feedback from others!')
                        else
                          Article.find(most_voted_id)
                        end
  end

  def show
    @categories = Category.all
  end

  def new
    @categories = Category.order(:priority)
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = 'Please select a set of categories'
      redirect_to article_path(@article)
    else
      @categories = Category.order(:priority)
      render :new
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :text, :user_id, :categories)
  end
end
