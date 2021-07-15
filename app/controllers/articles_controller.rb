class ArticlesController < ApplicationController 
  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :authenticate_user, except: :index

  # GET /articles or /articles.json
  def index
    @categories = Category.order(:priority)
    @categories_limited = @categories.slice(0,4)
    @featured_article = Article.find(
      Vote.find_by_sql(
        "SELECT article_id FROM votes 
        GROUP BY article_id 
        ORDER BY COUNT(user_id) 
        DESC LIMIT 1"
      ).first.try(:article_id)
    )
  end

  def show
  end

  def new
    @categories = Category.all
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article successfully created"
      redirect_to category_path(params[category_id])
    else
      @categories = Category.all
      render :new
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :text, :image, :user_id, :category_id)
    end
end
