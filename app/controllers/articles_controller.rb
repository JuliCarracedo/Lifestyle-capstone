class ArticlesController < ApplicationController 
  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :authenticate_user, except: :index

  # GET /articles or /articles.json
  def index
    @categories = Category.order(:priority)
    @categories_limited = @categories.slice(0,4)
    most_voted_id = Vote.find_by_sql(
      "SELECT article_id FROM votes 
      GROUP BY article_id 
      ORDER BY COUNT(user_id) 
      DESC LIMIT 1"
    ).first.try(:article_id)
    @featured_article = if most_voted_id.nil?
    
    Article.first ||  Article.new(title: "Create your own article",
       text: "People at Lifestyle want to know you better! Tell us your story and receive feedback from others!", 
       category_id: 1) 
    else
    Article.find(most_voted_id)
    end
  end

  def show
  end

  def new
    @categories = Category.order(:priority)
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article successfully created"
      @article.update(image: select_image(@article.category_id))
      redirect_to category_path(@article.category_id)
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
      params.require(:article).permit(:title, :text, :user_id, :category_id)
    end
    
   def select_image (id)
    case id # a_variable is the variable we want to compare
    when 1   
      "entertainment_bg.jpeg" 
    when 2    
      "tech_bg.jpeg"
    when 3    
      "daily_bg.jpeg"
    when 4    
      "politics_bg.jpeg"
    when 5    
      "arts_bg.jpeg"
    when 6    
      "sports_bg.jpeg"
    end
   end
end
